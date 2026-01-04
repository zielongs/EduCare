/*--------------------------------------------------
Author      : Siti Norlie Yana
Updated by  : Noraziela Binti Jepsin
Tested by   : Noraziela Binti Jepsin
Date        : 02 January 2026
Description : 
This screen is used by admin to view student
attendance by date. Admin can filter attendance
(All, Present, Absent) and generate a PDF report
for printing or downloading.
--------------------------------------------------*/

import 'package:flutter/foundation.dart'; // Used to check if app runs on Web
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart'; // PDF page format
import 'package:pdf/widgets.dart' as pw; // PDF widgets
import 'package:printing/printing.dart'; // Print and download PDF

import 'models/attendance.dart';
import 'data/mock_attendance.dart';

class AdminAttendanceScreen extends StatefulWidget {
  final VoidCallback? onBackToDashboard; // Callback for back button

  const AdminAttendanceScreen({super.key, this.onBackToDashboard});

  @override
  State<AdminAttendanceScreen> createState() => _AdminAttendanceScreenState();
}

class _AdminAttendanceScreenState extends State<AdminAttendanceScreen> {
  // Store selected date
  late DateTime selectedDate;
  // Store attendance records
  late List<Attendance> attendanceList;

  @override
  void initState() {
    super.initState();

    // Load mock attendance data
    attendanceList = mockAttendanceList;
    // Normalize selected date
    selectedDate = normalize(DateTime.now());

    // Debug: Print mock data info
    debugPrint("=== Mock Data Info ===");
    debugPrint("Total attendance records: ${attendanceList.length}");
    if (attendanceList.isNotEmpty) {
      for (
        var i = 0;
        i < (attendanceList.length > 5 ? 5 : attendanceList.length);
        i++
      ) {
        debugPrint(
          "  - ${attendanceList[i].studentName}: ${attendanceList[i].date}",
        );
      }
    }
    debugPrint("Today's date: $selectedDate");
    debugPrint("===================");
  }

  // Normalize date to ignore time
  DateTime normalize(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  /// Open date picker to choose attendance date
  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    // Update selected date if user picks one
    if (picked != null) setState(() => selectedDate = normalize(picked));
  }

  /// Check if two dates are the same day
  bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// Filtered attendance list based on tab index
  List<Attendance> filteredAttendance(int tabIndex) {
    final list = attendanceList.where((a) {
      if (!isSameDay(a.date, selectedDate)) return false;
      if (tabIndex == 1) return a.status == AttendanceStatus.present;
      if (tabIndex == 2) return a.status == AttendanceStatus.absent;
      return true;
    }).toList();

    // Sort students by name
    list.sort((a, b) => a.studentName.compareTo(b.studentName));
    return list;
  }

  /// Print or download PDF with better error handling
  Future<void> printAttendancePdf(int tabIndex) async {
    try {
      debugPrint("=== Print PDF Started ===");
      debugPrint("Tab Index: $tabIndex");
      debugPrint("Selected Date: $selectedDate");

      final list = filteredAttendance(tabIndex);
      debugPrint("Filtered attendance count: ${list.length}");

      // Show message if no data
      if (list.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "No attendance data for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }

      // Create PDF document
      final pdf = pw.Document();

      // Add PDF page
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Student Attendance Report",
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  "Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                ),
                pw.Text("Total Records: ${list.length}"),
                pw.SizedBox(height: 16),
                pw.TableHelper.fromTextArray(
                  headers: const ["Student", "Check In", "Check Out", "Status"],
                  data: list
                      .map(
                        (a) => [
                          a.studentName,
                          a.checkIn ?? "-",
                          a.checkOut ?? "-",
                          a.status.name.toUpperCase(),
                        ],
                      )
                      .toList(),
                  headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.grey300,
                  ),
                  cellAlignment: pw.Alignment.centerLeft,
                  cellHeight: 30,
                ),
              ],
            );
          },
        ),
      );

      // Web: download PDF
      final bytes = await pdf.save();
      debugPrint("PDF generated: ${bytes.length} bytes");

      // Download PDF on Web
      if (kIsWeb) {
        debugPrint("Web detected → sharePdf");
        await Printing.sharePdf(
          bytes: bytes,
          filename:
              'attendance_${selectedDate.day}_${selectedDate.month}_${selectedDate.year}.pdf',
        );

        // Success feedback for Web
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("PDF downloaded successfully"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        debugPrint("Non-web → layoutPdf");
        // Print dialog on Mobile/Desktop
        await Printing.layoutPdf(
          onLayout: (_) async => bytes,
          name: 'Attendance Report',
        );

        // Feedback for Mobile/Desktop
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Print dialog opened"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }

      debugPrint("=== Print PDF Completed ===");
    } catch (e, stack) {
      debugPrint("PDF ERROR: $e");
      debugPrint("$stack");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  /// Build attendance list cards
  Widget buildAttendanceList(List<Attendance> list) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.event_busy, size: 64, color: Colors.white70),
            const SizedBox(height: 16),
            Text(
              "No attendance records for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        final a = list[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: a.status == AttendanceStatus.present
                  ? Colors.green[200]
                  : Colors.red[200],
              child: Text(
                a.studentName[0],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(a.studentName),
            subtitle: Text(
              "In: ${a.checkIn ?? '-'} | Out: ${a.checkOut ?? '-'}",
            ),
            trailing: Text(
              a.status.name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: a.status == AttendanceStatus.present
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }

  /// Main UI build method
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
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
            onPressed: widget.onBackToDashboard,
          ),
          title: const Text(
            "STUDENT ATTENDANCE",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(
                    Icons.print,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  tooltip: "Print / Download PDF",
                  onPressed: () {
                    final controller = DefaultTabController.of(context);
                    final tabIndex = controller.index;
                    // Simple print to verify button works
                    debugPrint("PRINT ICON PRESSED | Tab: $tabIndex");
                    printAttendancePdf(tabIndex);
                  },
                );
              },
            ),
          ],

          bottom: const TabBar(
            labelColor: Color.fromARGB(255, 0, 0, 0),
            unselectedLabelColor: Color.fromARGB(179, 88, 85, 85),
            indicatorColor: Color.fromARGB(255, 35, 155, 16),
            tabs: [
              Tab(text: "All"),
              Tab(text: "Present"),
              Tab(text: "Absent"),
            ],
          ),
        ),

        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6FE3E1), Color(0xFF2B3FAE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit_calendar,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      onPressed: pickDate,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: TabBarView(
                    children: [
                      buildAttendanceList(filteredAttendance(0)),
                      buildAttendanceList(filteredAttendance(1)),
                      buildAttendanceList(filteredAttendance(2)),
                    ],
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


