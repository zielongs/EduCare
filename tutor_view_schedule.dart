/*--------------------------------------------------
Author      : Nur 'Aainaa Hamraa binti Hamka
Updated by  : 
Tested by   : 
Date        : 3 January 2026
Description : 
Tutor View Schedule Screen for the EduCare App.
- Displays tutor daily and weekly teaching schedule
- Allows date selection using horizontal calendar
- Shows class timeline with subject, student, and mode
- Includes bottom navigation for tutor modules
--------------------------------------------------*/
import 'package:flutter/material.dart';

class TutorViewSchedule extends StatefulWidget {
  const TutorViewSchedule({super.key});

  @override
  State<TutorViewSchedule> createState() => _TutorViewScheduleState();
}

class _TutorViewScheduleState extends State<TutorViewSchedule> {
  int _selectedDateIndex = 2;
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _days = [
    {'day': 'Mon', 'date': '16'},
    {'day': 'Tue', 'date': '17'},
    {'day': 'Wed', 'date': '18'},
    {'day': 'Thu', 'date': '19'},
    {'day': 'Fri', 'date': '20'},
    {'day': 'Sat', 'date': '21'},
    {'day': 'Sun', 'date': '22'},
  ];

  final Map<int, List<Map<String, String>>> _scheduleData = {
    2: [
      {
        'timeStart': '10:00',
        'timeEnd': '11:00',
        'subject': 'Mathematics Y1',
        'student': 'Student James',
        'mode': 'Physical',
      },
      {
        'timeStart': '11:00',
        'timeEnd': '12:00',
        'subject': 'English Y1',
        'student': 'Student James',
        'mode': 'Physical',
      },
      {
        'timeStart': '12:00',
        'timeEnd': '13:00',
        'subject': 'Bahasa Melayu Y3',
        'student': 'Student Felyana',
        'mode': 'Online',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4DD0E1), Color(0xFF283593)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/tutor-dashboard',
                        );
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '20 November',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // DAY SELECTOR
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: _days.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == _selectedDateIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDateIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 60,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF5097A4)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _days[index]['day'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _days[index]['date'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // TIMELINE
              Expanded(
                child: _scheduleData.containsKey(_selectedDateIndex)
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _scheduleData[_selectedDateIndex]!.length,
                        itemBuilder: (context, index) {
                          final data =
                              _scheduleData[_selectedDateIndex]![index];
                          return _buildTimelineItem(
                            data['timeStart']!,
                            data['timeEnd']!,
                            data['subject']!,
                            data['student']!,
                            data['mode']!,
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          "No classes scheduled",
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),

      /* ---------------- BOTTOM NAV (FIXED) ---------------- */
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == _currentIndex) return;

          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/tutor-dashboard');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/tutor-availability');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/tutor-notifications');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/tutor_profile');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Availability',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  /// Timeline item
  Widget _buildTimelineItem(
    String start,
    String end,
    String subject,
    String student,
    String mode,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  start,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  end,
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xFF5097A4),
                  border: Border.all(color: Colors.black87, width: 1.5),
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(child: Container(width: 2, color: Colors.black54)),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(
                              Icons.person_outline,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              student,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_city,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              mode,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4DD0E1).withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF00ACC1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


