import 'package:emp_system/controllers/supervisor_controller.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/model/attendace_model.dart';

class AttendanceList extends StatelessWidget {
  const AttendanceList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorController>(
      id: 'date',
      builder: (controller) => FutureBuilder<List<AttendanceData>>(
        future: controller.fetchAttendance(controller.selectedDate.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: primaryColor));
          } else if (snapshot.hasData && snapshot.data != null) {
            List<AttendanceData> attendanceList = snapshot.data!;
            if (attendanceList.isEmpty) {
              return Center(
                child: Text(
                  'No records exists',
                  style: TextStyle(color: Colors.grey, fontSize: 14.h),
                ),
              );
            }
            return ListView.separated(
              itemCount: attendanceList.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) =>
                  AttendanceTile(data: attendanceList[index]),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: Colors.grey, fontSize: 14.h),
              ),
            );
          } else {
            return Center(
              child: Text(
                'No records exists',
                style: TextStyle(color: Colors.grey, fontSize: 14.h),
              ),
            );
          }
        },
      ),
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
                  style: TextStyle(fontSize: 14.h, fontWeight: FontWeight.w500),
                ),

                // Employee ID
                Text(
                  data.id,
                  style: TextStyle(fontSize: 12.h, color: Colors.grey),
                ),

                // Employee Working hours
                Text(
                  "Working Hrs: ${calculateWorkingHours(data.checkInTime, data.checkOutTime)}",
                  style: TextStyle(fontSize: 12.h, color: Colors.grey),
                ),

                // Late reason
                if(data.isLate) Text(
                  "Reason for late: ${data.lateReason}",
                  style: TextStyle(fontSize: 12.h, color: Colors.grey),
                ),

                // Early lave reason
                if(data.isEarly) Text(
                  "Reason for early: ${data.earlyLeaveReason}",
                  style: TextStyle(fontSize: 12.h, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Attendance Timing
          Expanded(
            child: Text(
              data.checkInTime != null
                  ? DateFormat("h:mm").format(data.checkInTime!)
                  : "--:--",
              style: TextStyle(
                fontSize: 13.h,
                color: data.isLate ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: Text(
              data.checkOutTime != null
                  ? DateFormat("h:mm").format(data.checkOutTime!)
                  : "--:--",
              style: TextStyle(
                fontSize: 13.h,
                fontWeight: FontWeight.bold,
                color: data.isEarly ? Colors.red : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CALCULATE WORKING HOURS
String calculateWorkingHours(DateTime? checkInTime, DateTime? checkOutTime) {
  if (checkInTime == null || checkOutTime == null) return "--:--";

  Duration difference = checkOutTime.difference(checkInTime);

  int hours = difference.inHours;
  int minutes = difference.inMinutes % 60;

  return "${hours}h:${minutes}m";
}
