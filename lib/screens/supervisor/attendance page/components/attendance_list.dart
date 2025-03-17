import 'package:flutter/material.dart';

import '../../../../core/model/attendace_model.dart';


class AttendanceList extends StatelessWidget {
  final List<AttendanceData> employees;
  const AttendanceList({super.key, required this.employees});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: employees.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return AttendanceTile(data: employees[index]);
      },
    );
  }
}

// ATTENDANCE TILE
class AttendanceTile extends StatelessWidget {
  final AttendanceData data;
  const AttendanceTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Employee Name
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),

                // Employee ID
                const Text(
                  "123456\nUI/UX Designer",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Attendance Timing
          Expanded(
            child: Text(
              data.inTime,
              style: TextStyle(
                fontSize: 14,
                color: data.isLate ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: Text(
              data.outTime,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
