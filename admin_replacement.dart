import 'package:flutter/material.dart';

class AdminReplacementScreen extends StatefulWidget {
  const AdminReplacementScreen({super.key});

  @override
  State<AdminReplacementScreen> createState() => _AdminReplacementScreenState();
}

class _AdminReplacementScreenState extends State<AdminReplacementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
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
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'REQUEST REPLACEMENT CLASS',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Dec, 29 2025",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "12.34 PM",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white38, width: 1),
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF3F51B5),
                  unselectedLabelColor: Colors.black54,
                  indicatorColor: const Color(0xFF3F51B5),
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  tabs: const <Widget>[
                    Tab(text: "Pending (1)"),
                    Tab(text: "History"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[_buildPendingList(), _buildHistoryList()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPendingList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          _buildRequestCard(
            isPending: true,
            headerColor: const Color(0xFFFF5252),
            headerText: "UNCOMPLETED : Science",
            tutorName: "Norlie",
            originalDate: "Thu, Nov 15, 2026",
            originalTime: "9:00 AM - 10:00 AM",
            reqDate: "Fri, Nov 16, 2026",
            reqTime: "10:00 AM - 11:00 AM",
            reason: "Medical Personal",
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          _buildRequestCard(
            isPending: false,
            headerColor: const Color(0xFF00ACC1),
            headerText: "COMPLETED : Mathematics",
            tutorName: "Amir",
            originalDate: "Fri, Nov 9, 2026",
            originalTime: "9:00 AM - 10:00 AM",
            reqDate: "Mon, Nov 12, 2026",
            reqTime: "9:00 AM - 10:00 AM",
            reason: "Family Event",
            status: "Approved",
            statusColor: Colors.green,
          ),
          const SizedBox(height: 15),
          _buildRequestCard(
            isPending: false,
            headerColor: const Color(0xFF00ACC1),
            headerText: "COMPLETED : Bahasa Melayu",
            tutorName: "Ainaa",
            originalDate: "Thu, Nov 8, 2026",
            originalTime: "9:00 AM - 10:00 AM",
            reqDate: "Tue, Nov 13, 2026",
            reqTime: "9:00 AM - 10:00 AM",
            reason: "No Reason",
            status: "Rejected",
            statusColor: Colors.red,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildRequestCard({
    required bool isPending,
    required Color headerColor,
    required String headerText,
    required String tutorName,
    required String originalDate,
    required String originalTime,
    required String reqDate,
    required String reqTime,
    required String reason,
    String? status,
    Color? statusColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.person_outline, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    headerText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: "Tutor Name: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: tutorName),
                        ],
                      ),
                    ),
                    if (!isPending && status != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 15),
                _buildIconTextRow(
                  Icons.calendar_today,
                  "Original Date: $originalDate",
                  Colors.red,
                ),
                const SizedBox(height: 5),
                _buildIconTextRow(
                  Icons.access_time,
                  "Original Time: $originalTime",
                  Colors.red,
                ),
                const SizedBox(height: 10),
                _buildIconTextRow(
                  Icons.calendar_today,
                  "Requested Date: $reqDate",
                  Colors.green,
                ),
                const SizedBox(height: 5),
                _buildIconTextRow(
                  Icons.access_time,
                  "Requested Time: $reqTime",
                  Colors.green,
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                    children: <TextSpan>[
                      const TextSpan(
                        text: "Reason for absence: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: reason),
                    ],
                  ),
                ),
                if (isPending) ...<Widget>[
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Request Approved")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          "Approve",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Request Rejected")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEF5350),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          "Reject",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconTextRow(IconData icon, String text, Color color) {
    return Row(
      children: <Widget>[
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
