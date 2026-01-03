/*--------------------------------------------------
Author      : Noraziela Binti Jepsin
Updated by  : 
Tested by   : 
Date        : 28 December 2025
Description : 
Update Student Profile Screen for the EduCare App.
--------------------------------------------------*/

import 'package:flutter/material.dart';

class UpdateStudentProfileScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phone;
  final String gender;
  final String dateOfBirth;

  const UpdateStudentProfileScreen({
    super.key,
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.gender = '',
    this.dateOfBirth = '',
  });

  @override
  State<UpdateStudentProfileScreen> createState() =>
      _UpdateStudentProfileScreenState();
}

class _UpdateStudentProfileScreenState
    extends State<UpdateStudentProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _dateController;

  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _phoneController = TextEditingController(text: widget.phone);
    _dateController = TextEditingController(text: widget.dateOfBirth);
    selectedGender = widget.gender.isNotEmpty ? widget.gender : null;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using a SingleChildScrollView to prevent overflow when the keyboard appears
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // Consistent EduCare gradient theme
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF53E1E1), Color(0xFF1A237E)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      size: 40,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'UPDATE PROFILE',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balancing spacer
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Profile Picture with Pink Background Glow
            Stack(
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.pinkAccent,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://tinyurl.com/profile-avatar-yana',
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.indigo,
                      ),
                      onPressed: () {
                        // Handle image picker
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Photo picker coming soon!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              _lastNameController.text.isEmpty
                  ? _firstNameController.text.toUpperCase()
                  : '${_firstNameController.text} ${_lastNameController.text}'
                        .toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              'student123@educare.my',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 30),

            // Form Fields Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    _buildProfileField(
                      "What's your first name?",
                      _firstNameController,
                    ),
                    const SizedBox(height: 15),
                    _buildProfileField(
                      "And your last name?",
                      _lastNameController,
                    ),
                    const SizedBox(height: 15),
                    _buildPhoneField(),
                    const SizedBox(height: 15),
                    _buildDropdownField("Select your gender"),
                    const SizedBox(height: 15),
                    _buildDateField("What is your date of birth?"),
                    const SizedBox(height: 40),

                    // Update Button
                    ElevatedButton(
                      onPressed: () {
                        _updateProfile();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA7DED9),
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Update Profile',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable text input field
  Widget _buildProfileField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Specialized field for Phone Number with Flag icon
  Widget _buildPhoneField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.flag, color: Colors.green),
          ),
          Container(
            width: 1,
            height: 30,
            color: Colors.grey[300],
            margin: const EdgeInsets.symmetric(horizontal: 10),
          ),
          Expanded(
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: "Phone number",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Dropdown field
  Widget _buildDropdownField(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(color: Colors.black54)),
          value: selectedGender,
          items: genderOptions.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedGender = newValue;
            });
          },
        ),
      ),
    );
  }

  // Date picker field
  Widget _buildDateField(String hint) {
    return TextField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: const Icon(
          Icons.calendar_month_outlined,
          color: Colors.indigo,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Colors.indigo,
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          setState(() {
            _dateController.text =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          });
        }
      },
    );
  }

  void _updateProfile() {
    // Validate fields
    if (_firstNameController.text.isEmpty) {
      _showSnackBar('Please enter your first name');
      return;
    }

    if (_lastNameController.text.isEmpty) {
      _showSnackBar('Please enter your last name');
      return;
    }

    if (_phoneController.text.isEmpty) {
      _showSnackBar('Please enter your phone number');
      return;
    }

    if (selectedGender == null) {
      _showSnackBar('Please select your gender');
      return;
    }

    if (_dateController.text.isEmpty) {
      _showSnackBar('Please select your date of birth');
      return;
    }

    // Show success dialog and return updated data
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 30),
              SizedBox(width: 10),
              Text('Success'),
            ],
          ),
          content: const Text('Your profile has been updated successfully!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog

                // Return the updated data to the previous screen
                Navigator.pop(context, {
                  'firstName': _firstNameController.text,
                  'lastName': _lastNameController.text,
                  'phone': _phoneController.text,
                  'gender': selectedGender ?? '',
                  'dateOfBirth': _dateController.text,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red[400],
      ),
    );
  }
}
