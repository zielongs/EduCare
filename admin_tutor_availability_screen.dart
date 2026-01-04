/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : Noraziela Binti Jepsin
Tested by   : Noraziela Binti Jepsin
Date        : 02 January 2026
Description : 
This screen displays a list of tutors and allows
the user to search and filter tutors based on 
availability and subjects. Includes a search bar,
availability filters, and a list of tutor cards.
--------------------------------------------------*/

import 'package:flutter/material.dart';
import '../models/tutor.dart';
import '../widgets/search_bar.dart';
import '../widgets/tutor_card.dart';
import '../widgets/filter_card.dart';

/// Screen to display and filter tutor availability
class TutorAvailabilityScreen extends StatefulWidget {
  final List<Tutor> tutors;
  final VoidCallback? onBackToDashboard; // Callback for back button

  const TutorAvailabilityScreen({
    super.key,
    required this.tutors,
    this.onBackToDashboard,
  });

  @override
  State<TutorAvailabilityScreen> createState() =>
      _TutorAvailabilityScreenState();
}

class _TutorAvailabilityScreenState extends State<TutorAvailabilityScreen> {
  // Controller for the search bar
  final TextEditingController _searchController = TextEditingController();

  // ================= APPLIED FILTERS =================
  bool showAvailable = true;
  bool showNotAvailable = true;
  String selectedSubject = "All";

  // ================= TEMP FILTERS (for UI before applying) =================
  bool tempShowAvailable = true;
  bool tempShowNotAvailable = true;
  String tempSelectedSubject = "All";

  // Available subjects
  final List<String> subjects = [
    "All",
    "Mathematics",
    "Physics",
    "Chemistry",
    "Science",
    "Malay",
    "English",
  ];

  // List of tutors after filtering
  late List<Tutor> filteredTutors;

  @override
  void initState() {
    super.initState();
    filteredTutors = widget.tutors;

    // Sync temp filters with applied filters
    tempShowAvailable = showAvailable;
    tempShowNotAvailable = showNotAvailable;
    tempSelectedSubject = selectedSubject;
  }

  /// Filter tutors based on search query and filters
  void _filterTutors(String query) {
    setState(() {
      filteredTutors = widget.tutors.where((tutor) {
        final matchesSearch = tutor.name.toLowerCase().contains(
          query.toLowerCase(),
        );

        final matchesAvailability =
            (showAvailable && tutor.isAvailable) ||
            (showNotAvailable && !tutor.isAvailable);

        final matchesSubject =
            selectedSubject == "All" ||
            tutor.subjects.contains(selectedSubject);

        return matchesSearch && matchesAvailability && matchesSubject;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 40,
            color: Colors.black,
          ),
          onPressed: widget.onBackToDashboard ?? () => Navigator.pop(context),
        ),
        title: const Text(
          "FIND TUTOR",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      // ===== BODY =====
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4ADEDE), Color(0xFF7BD5F5), Color(0xFF1F2F98)],
          ),
        ),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= SEARCH BAR =================
              Padding(
                padding: const EdgeInsets.all(16),
                child: SearchBarWidget(
                  controller: _searchController,
                  onChanged: _filterTutors,
                ),
              ),

              // ================= AVAILABILITY FILTER =================
              FilterCard(
                showAvailable: tempShowAvailable,
                showNotAvailable: tempShowNotAvailable,
                selectedSubject: tempSelectedSubject,
                subjects: subjects,
                onAvailableChanged: (value) {
                  setState(() {
                    tempShowAvailable = value!;
                  });
                },
                onNotAvailableChanged: (value) {
                  setState(() {
                    tempShowNotAvailable = value!;
                  });
                },
                onSubjectChanged: (value) {
                  setState(() {
                    tempSelectedSubject = value!;
                  });
                },
                onApply: () {
                  setState(() {
                    showAvailable = tempShowAvailable;
                    showNotAvailable = tempShowNotAvailable;
                    selectedSubject = tempSelectedSubject;
                  });
                  _filterTutors(_searchController.text);
                },
                onReset: () {
                  setState(() {
                    showAvailable = true;
                    showNotAvailable = true;
                    selectedSubject = "All";

                    tempShowAvailable = true;
                    tempShowNotAvailable = true;
                    tempSelectedSubject = "All";

                    _searchController.clear();
                    filteredTutors = widget.tutors;
                  });
                },
              ),

              // ================= SECTION TITLE =================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Available Tutors",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // ================= TUTOR LIST =================
              Expanded(
                child: filteredTutors.isEmpty
                    ? const Center(
                        child: Text(
                          "No tutors found",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredTutors.length,
                        itemBuilder: (context, index) {
                          return TutorCard(tutor: filteredTutors[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
