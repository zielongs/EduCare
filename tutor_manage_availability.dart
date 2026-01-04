/*--------------------------------------------------
Author      : Nur 'Aainaa Hamraa binti Hamka
Updated by  : 
Tested by   : 
Date        : 30 December 2025
Description : 
Tutor Manage Availability Screen for the EduCare App.
- Allows tutors to set weekly teaching availability
- Supports multiple time slots per day
- Displays weekly availability summary
- Data will be used by admin for tutor scheduling
--------------------------------------------------*/
import 'package:flutter/material.dart';

class TutorManageAvailability extends StatefulWidget {
  const TutorManageAvailability({super.key});

  @override
  State<TutorManageAvailability> createState() =>
      _TutorManageAvailabilityState();
}

class _TutorManageAvailabilityState extends State<TutorManageAvailability> {
  final List<Map<String, dynamic>> _weekAvailability = [
    _day('MON', '24/11/2025'),
    _day('TUE', '25/11/2025'),
    _day('WED', '26/11/2025'),
    _day('THU', '27/11/2025'),
    _day('FRI', '28/11/2025'),
    _day('SAT', '29/11/2025'),
    _day('SUN', '30/11/2025'),
  ];

  static Map<String, dynamic> _day(String day, String date) => {
    'day': day,
    'date': date,
    'on': false,
    'slots': <Map<String, String>>[],
  };

  static Map<String, String> _slot() => {
    'start': '10',
    'startPeriod': 'AM',
    'end': '12',
    'endPeriod': 'PM',
    'mode': 'Physical',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF53E1E1), Color(0xFF1A237E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const Text(
                      'This week slot:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    ..._weekAvailability.map(_buildDayCard),

                    const SizedBox(height: 20),
                    _buildWeeklySummaryTable(),
                    const SizedBox(height: 20),
                    _buildSubmitButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* ================= HEADER ================= */
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // 🔹 Go back to Tutor Dashboard
              Navigator.pushReplacementNamed(context, '/tutor-dashboard');
            },
          ),
          const SizedBox(width: 10),
          const Text(
            'MANAGE AVAILABILITY',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }

  /* ================= DAY CARD ================= */
  Widget _buildDayCard(Map<String, dynamic> day) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day + ON/OFF
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${day['day']} (${day['date']})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(day['on'] ? 'ON' : 'OFF'),
                  Switch(
                    value: day['on'],
                    onChanged: (value) {
                      setState(() {
                        day['on'] = value;
                        if (value && day['slots'].isEmpty) {
                          day['slots'].add(_slot());
                        }
                        if (!value) {
                          day['slots'].clear();
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),

          if (day['on']) ...[
            const SizedBox(height: 10),
            ...day['slots'].map(_buildSlotUI),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    day['slots'].add(_slot());
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text('Add another slot'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /* ================= SLOT UI ================= */
  Widget _buildSlotUI(Map<String, String> slot) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F5FE),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // START & END TIME (SIDE BY SIDE)
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Start Time'),
                    Row(
                      children: [
                        Expanded(child: _hourBox(slot, 'start')),
                        const Text(' : 00  '),
                        _amPmToggle(slot, 'startPeriod'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('End Time'),
                    Row(
                      children: [
                        Expanded(child: _hourBox(slot, 'end')),
                        const Text(' : 00  '),
                        _amPmToggle(slot, 'endPeriod'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // MODE
          Row(
            children: [
              const Text('Mode'),
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: slot['mode'],
                items: const [
                  DropdownMenuItem(value: 'Physical', child: Text('Physical')),
                  DropdownMenuItem(value: 'Online', child: Text('Online')),
                ],
                onChanged: (value) {
                  setState(() {
                    slot['mode'] = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _hourBox(Map<String, String> slot, String key) {
    return TextFormField(
      initialValue: slot[key],
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        slot[key] = value;
        setState(() {});
      },
    );
  }

  Widget _amPmToggle(Map<String, String> slot, String key) {
    return ToggleButtons(
      isSelected: [slot[key] == 'AM', slot[key] == 'PM'],
      onPressed: (index) {
        setState(() {
          slot[key] = index == 0 ? 'AM' : 'PM';
        });
      },
      children: const [
        Padding(padding: EdgeInsets.all(4), child: Text('AM')),
        Padding(padding: EdgeInsets.all(4), child: Text('PM')),
      ],
    );
  }

  /* ================= WEEKLY SUMMARY TABLE ================= */
  Widget _buildWeeklySummaryTable() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFB2EBF2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Availability Summary',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(3),
            },
            children: [
              const TableRow(
                children: [
                  Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Start', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('End', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Mode', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              ..._weekAvailability.expand((day) {
                if (!day['on']) {
                  return [
                    TableRow(
                      children: [
                        Text(day['date']),
                        const Text('-'),
                        const Text('-'),
                        const Text('Not Available'),
                      ],
                    ),
                  ];
                }
                return day['slots'].map<TableRow>((slot) {
                  return TableRow(
                    children: [
                      Text(day['date']),
                      Text('${slot['start']}${slot['startPeriod']}'),
                      Text('${slot['end']}${slot['endPeriod']}'),
                      Text(slot['mode']!),
                    ],
                  );
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  /* ================= SUBMIT ================= */
  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Availability submitted successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      child: const Text('SUBMIT'),
    );
  }
}
