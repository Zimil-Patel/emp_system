import 'package:emp_system/theme/app_theme.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'components/employe_lists.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
      ),
      body: Column(
        children: [
          // TOTAL EMPLOYEE
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Employees:",
                  style: TextStyle(fontSize: 14.h, fontWeight: FontWeight.bold),
                ),
                Obx(
                  () => Text(
                    " ${supervisorController.employeeList.length}",
                    style: TextStyle(
                        fontSize: 14.h,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                ),
              ],
            ),
          ),

          Divider(),
          // TITLES
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.h),
                ),
              ),
              Expanded(
                child: Text(
                  "Preview",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Divider(),

          // EMPLOYEE LIST
          Expanded(
            child: EmployeeList(),
          ),
        ],
      ),
    );
  }
}
