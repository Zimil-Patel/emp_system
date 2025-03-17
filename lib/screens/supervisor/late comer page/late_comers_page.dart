import 'package:flutter/material.dart';

import '../../../core/model/attendace_model.dart';
import '../attendance page/components/attendance_list.dart';

class LateComersPage extends StatelessWidget {
  const LateComersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Late Comers"),
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
                AttendanceData("Md. Rakibul Islam", "10:55", "--:--", true),
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
