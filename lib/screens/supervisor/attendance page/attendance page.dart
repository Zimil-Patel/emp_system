import 'package:emp_system/screens/supervisor/attendance%20page/components/filter_and_export_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/attendance_list.dart';
import 'components/attendance_refresh_button.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
        actions: [
          AttendanceRefreshButton(),
          SizedBox(width: 12.w),
        ],
      ),
      body: Column(
        children: [
          // DATE FILTER
          FilterAndExportSection(),

          // TABLE TITLE
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.h,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.h,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Out",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.h,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ATTENDANCE LIST
          Expanded(child: AttendanceList()),
        ],
      ),
    );
  }
}


