import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../attendance page/components/attendance_list.dart';
import '../attendance page/components/attendance_refresh_button.dart';
import '../attendance page/components/filter_and_export_section.dart';

class LateComersPage extends StatelessWidget {
  const LateComersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Late Comers"),
        actions: [
          AttendanceRefreshButton(),
          SizedBox(width: 12.w),
        ],
      ),
      body: Column(
        children: [
          // DATE FILTER
          FilterAndExportSection(title: "Late comers"),

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
            child: AttendanceList(),
          ),
        ],
      ),
    );
  }
}
