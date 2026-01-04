/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : Noraziela Binti Jepsin
Tested by   : Noraziela Binti Jepsin
Date        : 02 January 2026
Description : 
This screen displays detailed information about a 
selected tutor, including name, subjects, status, 
students, and weekly availability. Users can select 
a date range to filter availability.
--------------------------------------------------*/

import 'package:flutter/material.dart';
import 'models/tutor.dart';

/// Screen to display tutor details and weekly availability
class TutorDetailScreen extends StatefulWidget {
  final Tutor tutor; // Tutor to display

  const TutorDetailScreen({super.key, required this.tutor});

  @override
  State<TutorDetailScreen> createState() => _TutorDetailScreenState();
}

class _TutorDetailScreenState extends State<TutorDetailScreen> {
  // Selected date range for filtering availability
  DateTimeRange? selectedDateRange;

  // Weekly availability from the tutor
  List<Map<String, dynamic>> get weeklyAvailability =>
      widget.tutor.availability;

  /// Opens the date range picker
  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDateRange: selectedDateRange,
    );

    if (picked != null) {
      setState(() => selectedDateRange = picked);
    }
  }

  /// Clears the selected date range
  void _clearDateFilter() {
    setState(() {
      selectedDateRange = null;
    });
  }

  /// Formats DateTime as DD/MM/YYYY
  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  /// Returns availability filtered by selected date range
  List<Map<String, dynamic>> get filteredAvailability {
    if (selectedDateRange == null) return weeklyAvailability;

    return weeklyAvailability.where((item) {
      final date = item["date"] as DateTime;
      return !date.isBefore(selectedDateRange!.start) &&
          !date.isAfter(selectedDateRange!.end);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 40,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${widget.tutor.name.toUpperCase()}'S AVAILABILITY",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4ADEDE), Color(0xFF7BD5F5), Color(0xFF1F2F98)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= TUTOR DETAILS CARD =================
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: const Color.fromARGB(255, 212, 255, 209),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tutor Name
                          Text(
                            "Tutor Name: ${widget.tutor.name}",
                            style: const TextStyle(
                              fontSize: 20, // bigger
                              fontWeight: FontWeight.bold, // stand out
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Subjects
                          Text(
                            "Subjects: ${widget.tutor.subjects.join(', ')}",
                            style: const TextStyle(
                              fontSize: 18, // slightly smaller than title
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Current Status
                          Text(
                            "Current Status: ${widget.tutor.isAvailable ? "Available" : "Not Available"}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: widget.tutor.isAvailable
                                  ? Colors.green[800]
                                  : Colors.red[800],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Students
                          Text(
                            "Students: ${widget.tutor.students.join(', ')}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ================= DATE RANGE PICKER =================
                const Text(
                  "Select a date:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    // Date picker field
                    Expanded(
                      child: InkWell(
                        onTap: _pickDateRange,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDateRange == null
                                    ? "Select date range"
                                    : "${_formatDate(selectedDateRange!.start)} - ${_formatDate(selectedDateRange!.end)}",
                              ),
                              const Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Clear button (only visible if a date range is selected)
                    if (selectedDateRange != null)
                      IconButton(
                        onPressed: _clearDateFilter,
                        icon: const Icon(Icons.clear),
                        tooltip: "Clear date filter",
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                // ================= AVAILABILITY TABLE =================
                const Text(
                  "Weekly Availability:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // TABLE HEADER
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Hours & Mode",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // TABLE ROWS
                        Expanded(
                          child: filteredAvailability.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No availability in this date range",
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: filteredAvailability.length,
                                  itemBuilder: (context, index) {
                                    final item = filteredAvailability[index];

                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              _formatDate(item["date"]),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  item["subject"],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(item["time"]),
                                                if (item["mode"].isNotEmpty)
                                                  Text(
                                                    item["mode"],
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

