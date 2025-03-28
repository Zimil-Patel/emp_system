import 'package:emp_system/core/model/employee_model.dart';
import 'package:emp_system/screens/supervisor/employee%20list%20page/employee_list_page.dart';
import 'package:emp_system/screens/supervisor/home%20page/components/supervisor_drawer.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_theme.dart';

class SupervisorHomePage extends StatelessWidget {
  const SupervisorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supervisor Dashboard"),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Text(
              "Welcome, Supervisor!",
              style: TextStyle(
                fontSize: 22.h,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),

            // Quick Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionCard(Icons.group, "Employees"),
                _buildActionCard(Icons.assignment, "Tasks"),
                _buildActionCard(Icons.analytics, "Reports"),
              ],
            ),
            SizedBox(height: 20.h),

            // Recent Activity
            Text("Registration Requests",
                style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.w600)),
            SizedBox(height: 10.h),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemBuilder: (context, index) => _employeeRequestCard(
                      supervisorController.employeeList[index]),
                  itemCount: supervisorController.employeeList.length,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: SupervisorDrawer(),
    );
  }

  // Action Card Widget
  Widget _buildActionCard(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        if(label != 'Employees'){
          Get.snackbar(
            'Feature Coming Soon!',
            'This feature is not yet implemented. Stay tuned for future updates!',
            icon: Icon(Icons.construction, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange.shade700,
            colorText: Colors.white,
            duration: Duration(seconds: 3),
            margin: EdgeInsets.all(12),
            borderRadius: 10,
            padding: EdgeInsets.all(12),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        } else {
          Get.to(() => EmployeeListPage());
        }
      },
      child: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36.sp, color: primaryColor),
            SizedBox(height: 8.h),
            Text(label,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  // Recent Activity List Tile
  Widget _employeeRequestCard(EmployeeModel employee) {
    bool isApproved = employee.isVerified;

    return Card(
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: primaryColor.withOpacity(0.1),
      color: primaryColor.withOpacity(0.1),
      child: ListTile(
        tileColor: primaryColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: Icon(Icons.person, color: primaryColor),
        title: Text(
          employee.name,
          style: TextStyle(fontSize: 14.h),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              employee.email,
              style: TextStyle(fontSize: 12.h),
            ),
            Text(
              isApproved ? "Approved" : "Not Approved",
              style: TextStyle(
                  fontSize: 12.h,
                  color: isApproved ? primaryColor : Colors.red.shade300),
            ),
          ],
        ),
        trailing: CupertinoButton(
          onPressed: () async {
            if (isApproved) {
              await supervisorController.approveEmployeeRequest(
                  email: employee.email, value: false, employeeId: employee.employeeId);
            } else {
              await supervisorController.approveEmployeeRequest(
                  email: employee.email, value: true, employeeId: employee.employeeId);
            }

          },
          padding: EdgeInsets.zero,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 4.h),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Text(
              isApproved ? 'Cancel' : 'Approve',
              style: TextStyle(
                fontFamily: 'VarelaRounded',
                  fontSize: 14.h,
                  color: isApproved ? Colors.red.shade400 : primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
