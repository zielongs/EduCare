/*--------------------------------------------------
Author      : Nur 'Aainaa Hamraa binti Hamka
Updated by  : 
Tested by   : 
Date        : 1 January 2026
Description : 
Admin Notifications Screen for the EduCare App.
- Allows admin to send notifications to users
- Supports sending to all users, tutors, students, or individuals
- Includes subject, message content, and file attachment
--------------------------------------------------*/
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AdminNotifications extends StatefulWidget {
  const AdminNotifications({super.key});

  @override
  State<AdminNotifications> createState() => _AdminNotificationsState();
}

class _AdminNotificationsState extends State<AdminNotifications> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String _recipientType = 'All Users';
  String? _attachedFileName;

  final List<String> _recipientOptions = [
    'All Users',
    'All Tutors',
    'All Students',
    'Specific User',
  ];

  /* ---------------- CLEAR FORM ---------------- */
  void _clearForm() {
    setState(() {
      _recipientType = 'All Users';
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
      _attachedFileName = null;
    });
  }

  /* ---------------- PICK FILE ---------------- */
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _attachedFileName = result.files.single.name;
      });
    }
  }

  /* ---------------- SEND ---------------- */
  void _sendNotification() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Sent!'),
        content: const Text('Notification has been sent successfully.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _clearForm();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
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
              /* ---------------- HEADER ---------------- */
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        // BACK TO EXISTING ADMIN DASHBOARD
                        Navigator.pushReplacementNamed(
                          context,
                          '/admin_dashboard',
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'SEND NOTIFICATIONS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              /* ---------------- FORM ---------------- */
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'New message',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15),

                        /* Recipient Type */
                        const Text('To'),
                        DropdownButtonFormField<String>(
                          value: _recipientType,
                          items: _recipientOptions
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _recipientType = value!;
                              if (_recipientType != 'Specific User') {
                                _emailController.clear();
                              }
                            });
                          },
                        ),

                        const SizedBox(height: 15),

                        /* Email (only if specific user) */
                        if (_recipientType == 'Specific User') ...[
                          const Text('Recipient Email'),
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: 'example@email.com',
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],

                        /* Subject */
                        const Text('Subject'),
                        TextField(
                          controller: _subjectController,
                          decoration: const InputDecoration(
                            hintText: 'Write here...',
                          ),
                        ),
                        const SizedBox(height: 15),

                        /* Message */
                        TextField(
                          controller: _messageController,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            hintText: 'Message',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15),

                        /* Attach File */
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: _pickFile,
                              icon: const Icon(Icons.attach_file),
                              label: const Text('Attach a file'),
                            ),
                            const SizedBox(width: 10),
                            if (_attachedFileName != null)
                              Expanded(
                                child: Text(
                                  _attachedFileName!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        /* Send + Delete */
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _sendNotification,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                child: const Text('Send Notifications'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: _clearForm,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

