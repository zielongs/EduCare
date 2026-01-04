import 'package:flutter/material.dart';

class StudentScheduleScreen extends StatefulWidget {
  const StudentScheduleScreen({super.key});

  @override
  State<StudentScheduleScreen> createState() => _StudentScheduleScreenState();
}

class _StudentScheduleScreenState extends State<StudentScheduleScreen> {
  int _selectedDateIndex = 2;

  final List<Map<String, dynamic>> _days = [
    {'day': 'Mon', 'date': '12'},
    {'day': 'Tue', 'date': '13'},
    {'day': 'Wed', 'date': '14'},
    {'day': 'Thu', 'date': '15'},
    {'day': 'Fri', 'date': '16'},
    {'day': 'Sat', 'date': '17'},
    {'day': 'Sun', 'date': '18'},
  ];

  final Map<int, List<Map<String, String>>> _scheduleData = {
    0: [
      {
        'timeStart': '08:00',
        'timeEnd': '10:00',
        'subject': 'English',
        'tutor': 'Tutor Ziela',
        'mode': 'Physical',
        'icon': 'book',
      },
      {
        'timeStart': '10:00',
        'timeEnd': '12:00',
        'subject': 'History',
        'tutor': 'Tutor Ahmad',
        'mode': 'Online',
        'icon': 'history',
      },
    ],
    1: [
      {
        'timeStart': '09:00',
        'timeEnd': '11:00',
        'subject': 'Science',
        'tutor': 'Tutor Norlie',
        'mode': 'Physical',
        'icon': 'science',
      },
    ],
    2: [
      {
        'timeStart': '09:00',
        'timeEnd': '10:00',
        'subject': 'Mathematics',
        'tutor': 'Tutor Amir',
        'mode': 'Physical',
        'icon': 'math',
      },
      {
        'timeStart': '10:00',
        'timeEnd': '11:00',
        'subject': 'English',
        'tutor': 'Tutor Ziela',
        'mode': 'Physical',
        'icon': 'book',
      },
      {
        'timeStart': '13:00',
        'timeEnd': '14:00',
        'subject': 'Bahasa Melayu',
        'tutor': 'Tutor Ainaa',
        'mode': 'Online',
        'icon': 'language',
      },
    ],
    3: [
      {
        'timeStart': '14:00',
        'timeEnd': '16:00',
        'subject': 'Physics',
        'tutor': 'Tutor John',
        'mode': 'Physical',
        'icon': 'science',
      },
    ],
    4: [
      {
        'timeStart': '08:00',
        'timeEnd': '10:00',
        'subject': 'Science',
        'tutor': 'Tutor Norlie',
        'mode': 'Physical',
        'icon': 'science',
      },
    ],
  };

  void _onBottomNavTapped(int index) {
    if (index == 0) {
       Navigator.pushNamed(context, '/student_dashboard');
    } else if (index == 1) {
       Navigator.pushNamed(context, '/student_attendance');
    } else if (index == 2) {
       Navigator.pushNamed(context, '/notification');
    } else if (index == 3) {
       Navigator.pushNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF3F51B5),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: 0,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.black87,
                      ),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '15 November',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const Text(
                      'Tomorrow',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
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
              Expanded(
                child: _scheduleData.containsKey(_selectedDateIndex)
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: _scheduleData[_selectedDateIndex]!.length,
                        itemBuilder: (context, index) {
                          final data = _scheduleData[_selectedDateIndex]![index];
                          return _buildTimelineItem(
                            data['timeStart']!,
                            data['timeEnd']!,
                            data['subject']!,
                            data['tutor']!,
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
    );
  }

  Widget _buildTimelineItem(
    String start,
    String end,
    String subject,
    String tutor,
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
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
                            color: Colors.black87,
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
                              tutor,
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
