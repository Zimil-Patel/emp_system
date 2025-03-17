import 'package:flutter/material.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date Picker
                DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Text('18 Mar 2025'),
                    )
                  ],
                  onChanged: (value) {},
                ),

                // TOTAL EMPLOYEE AND CSV PDF
                const Row(
                  children: [
                    Text(
                      "Total Employees: ",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "25",
                      style: TextStyle(fontSize: 14, color: Colors.green),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "CSV",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "|",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "PDF",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // TABLE TITLE
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.grey[200],
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 3,
                    child: Text("Name",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("In",
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text("Out",
                        style: TextStyle(fontWeight: FontWeight.bold))),
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
