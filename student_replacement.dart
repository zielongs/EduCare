import 'package:flutter/material.dart';

class StudentReplacementScreen extends StatefulWidget {
  const StudentReplacementScreen({super.key});

  @override
  State<StudentReplacementScreen> createState() =>
      _StudentReplacementScreenState();
}

class _StudentReplacementScreenState extends State<StudentReplacementScreen> {
  String? _selectedReason;
  String? _selectedMode;
  int? _selectedReplacementOption;

  final List<String> _reasons = <String>[
    'Medical',
    'Personal',
    'School Activity',
    'Other',
  ];

  final List<String> _modes = <String>[
    'Synchronous (Online Live)',
    'Asynchronous (Recorded)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFF4DD0E1), Color(0xFF283593)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 36,
                        color: Colors.black87,
                      ),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Request Replacement Class',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.person_outline,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Original Class",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      _buildInfoRow("Subject:", "Mathematics"),
                      const SizedBox(height: 8),
                      _buildInfoRow("Date:", "Thu, Nov 15, 2026"),
                      const SizedBox(height: 8),
                      _buildInfoRow("Time:", "9:00 AM - 10:00 AM"),
                      const SizedBox(height: 20),
                      const Text(
                        "Reason for Absence",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text("Select Reason"),
                            value: _selectedReason,
                            items: _reasons.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedReason = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(Icons.cached, color: Colors.black54),
                          const SizedBox(width: 10),
                          const Text(
                            "Select Replacement Option",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      _buildRadioOption(
                        0,
                        "Mathematics (Fri, Nov 16, 2:00 PM)",
                      ),
                      _buildRadioOption(
                        1,
                        "Mathematics (Mon, Nov 19, 10:00 AM)",
                      ),
                      _buildRadioOption(
                        2,
                        "Mathematics (Tue, Nov 20, 8:00 AM)",
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Select Class Mode",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text("Select Class Mode"),
                            value: _selectedMode,
                            items: _modes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedMode = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedReason != null &&
                          _selectedReplacementOption != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Request Submitted Successfully!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please select a reason and a replacement slot.",
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Submit Request",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: <Widget>[
        Text(
          "$label ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(value, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

  Widget _buildRadioOption(int value, String text) {
    return RadioListTile<int>(
      value: value,
      groupValue: _selectedReplacementOption,
      onChanged: (int? newValue) {
        setState(() {
          _selectedReplacementOption = newValue;
        });
      },
      title: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.black87),
      ),
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      activeColor: Colors.black87,
    );
  }
}
