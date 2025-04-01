import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  final String email; // Pass Employee ID for fetching attendance

  const CalendarPage({super.key, required this.email});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Map<String, String> attendanceData = {};

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    try {
      Map<String, String> data = {};

      DocumentSnapshot employeeDoc = await FirebaseFirestore.instance
          .collection('employees')
          .doc(widget.email)
          .get();

      Timestamp joiningTimestamp = employeeDoc['createdAt'];
      DateTime joiningDate = joiningTimestamp.toDate();

      // Get all check-in records from Firestore
      QuerySnapshot checkInSnapshot = await FirebaseFirestore.instance
          .collection('employees')
          .doc(widget.email)
          .collection('checkIns')
          .get();

      Map<String, Map<String, dynamic>> checkInData = {};
      for (var doc in checkInSnapshot.docs) {
        checkInData[doc.id] = doc.data() as Map<String, dynamic>;
      }

      DateTime today = DateTime.now();

      for (DateTime date = joiningDate;
          date.isBefore(today) || date.isAtSameMomentAs(today);
          date = date.add(Duration(days: 1))) {
        String dateKey =
            DateFormat('yyyy-MM-dd').format(date); // Format date as key

        // Skip weekends (Saturday & Sunday)
        if (date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday) {
          continue;
        }

        if (checkInData.containsKey(dateKey)) {
          Map<String, dynamic>? record = checkInData[dateKey];

          if (record == null) continue;

          // Check if employee was late
          if (record['checkInTime'] != null) {
            data[dateKey] = 'Present';
            if (record['lateReason'] != null) {
              data[dateKey] = 'Late';
            }
          }

          // Check if employee was early leaver
          if (record['checkOutTime'] != null) {
            if (record['earlyLeaveReason'] != null) {
              data[dateKey] = 'Early Leave';
            }
          }

          if (record['checkOutTime'] != null && record['checkInTime'] != null) {
            if (record['lateReason'] != null &&
                record['earlyLeaveReason'] != null) {
              data[dateKey] = 'Late & Early';
            }
          }
        } else {
          data[dateKey] = 'Absent';
        }
      }

      setState(() {
        attendanceData = data;
        log(attendanceData.toString());
      });
    } catch (e) {
      print("Error fetching attendance data: $e");
    }
  }

  Color getColorForDate(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
      return Colors.grey; // Weekend (Week Off)
    }

    switch (attendanceData[formattedDate]) {
      case 'Present':
        return Colors.green.shade200;
      case 'Absent':
        return Colors.red;
      case 'Late & Early':
        return Colors.blue.shade200;
      case 'Late':
        return Colors.pink.shade200;
      case 'Early Leave':
        return Colors.purple.shade200;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calendar")),
      body: Column(
        children: [
          // Status INDICATOR INFO
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              children: [
                statusIndicator("Present", Colors.green.shade200),
                statusIndicator("Absent", Colors.red),
                statusIndicator("Late & Early", Colors.blue.shade200),
                statusIndicator("Week Off", Colors.grey),
                statusIndicator("Late", Colors.pink.shade200),
                statusIndicator("Early Leave", Colors.purple.shade200),
              ],
            ),
          ),

          // Calendar
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay: DateTime.now(),
                focusedDay: DateTime.now(),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, _) {
                    return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: getColorForDate(date),
                      ),
                      child: Text(
                        "${date.day}",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget statusIndicator(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 12,
            height: 12,
            color: color,
            margin: EdgeInsets.symmetric(vertical: 8)),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 13.h)),
        SizedBox(width: 4),
      ],
    );
  }
}
