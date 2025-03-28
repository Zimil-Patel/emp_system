import 'package:emp_system/screens/supervisor/attendance%20page/components/filter_and_export_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/model/attendace_model.dart';
import 'components/attendance_list.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
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
          Expanded(
            child: AttendanceList(
              employees: const [
                AttendanceData("Faius Mojumder Nahin", "09:55", "--:--", false),
                AttendanceData("Md. Sharek", "09:43", "17:30", false),
                AttendanceData("Istiayk Milon", "09:25", "19:23", false),
                AttendanceData("Md. Rakibul Islam", "10:55", "--:--", true),
                AttendanceData("Md. Sorif", "10:00", "17:42", false),
                AttendanceData("Md. Mobusshar Islam", "09:50", "18:02", false),
                AttendanceData("Md. Ratul", "10:15", "17:00", true),
                AttendanceData("Md. Atik", "10:07", "18:09", true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
