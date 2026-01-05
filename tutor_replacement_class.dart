/*--------------------------------------------------
Author      : Nur 'Aainaa Hamraa binti Hamka
Updated by  : Noraziela Binti Jepsin
Tested by   : Noraziela Binti Jepsin
Date        : 1 January 2026
Description : 
Tutor Replacement Class Screen for the EduCare App.
- Displays details of replacement class requests
- Allows tutor to accept or decline replacement classes
- Sends response back to admin (mock / future Firebase)
--------------------------------------------------*/
import 'package:flutter/material.dart';

class TutorReplacementClass extends StatelessWidget {
  const TutorReplacementClass({super.key});

  void _respond(BuildContext context, String response) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Response Sent'),
        content: Text(
          response == 'YES'
              ? 'You have accepted the replacement class.'
              : 'You have declined the replacement class.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // back to notifications
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* ---------------- BACK BUTTON ---------------- */
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),

                const SizedBox(height: 10),

                /* ---------------- TITLE BOX ---------------- */
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 25,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB2EBF2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Replacement Class',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /* ---------------- CLASS DETAILS BOX ---------------- */
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Class Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text('• Student: Aiman Hakimi'),
                      Text('• Subject: Mathematics'),
                      Text('• Date: 27/11/2025 (Thursday)'),
                      Text('• Time: 10:00 AM – 1:00 PM'),
                      Text('• Mode: Physical'),
                      Text('• Requested by: Admin (Ms. Farah)'),
                      SizedBox(height: 12),
                      Text(
                        'Reason:\nThe original tutor is unavailable due to medical leave. '
                        'Can you take this replacement class as you\'re available at this time?',
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                /* ---------------- ACTION BUTTONS ---------------- */
                ElevatedButton(
                  onPressed: () => _respond(context, 'YES'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text('YES'),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () => _respond(context, 'NO'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: const Text('NO'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


