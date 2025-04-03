import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/model/attendace_model.dart';
import '../../../../utils/constants.dart';

class AttendanceList extends StatelessWidget {
  final String filter;

  const AttendanceList({super.key, this.filter = 'All'});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if(filter == 'Early'){
          supervisorController.filteredList.value = supervisorController.attendanceList.where((attendance) => attendance.isEarly == true).toList();
        } else if(filter == 'Late'){
          supervisorController.filteredList.value = supervisorController.attendanceList.where((attendance) => attendance.isLate == true).toList();
        } else {
          supervisorController.filteredList.value = supervisorController.attendanceList;
        }
        return ListView.separated(
          itemCount: supervisorController.filteredList.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            return AttendanceTile(data: supervisorController.filteredList[index]);
          },
        );
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
                  style: TextStyle(fontSize: 14.h, fontWeight: FontWeight.w500),
                ),

                // Employee ID
                Text(
                  data.id,
                  style: TextStyle(fontSize: 12.h, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Attendance Timing
          Expanded(
            child: Text(
              data.checkInTime ?? "--:--",
              style: TextStyle(
                fontSize: 13.h,
                color: data.isLate ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: Text(
              data.checkOutTime ?? "--:--",
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
