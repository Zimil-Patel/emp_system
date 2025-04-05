import 'package:emp_system/screens/employee/leave%20page/components/add_leave_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/constants.dart';
import 'components/leave_request_list.dart';

class LeavePage extends StatelessWidget {
  LeavePage({super.key});


  bool get isSupervisor => authController.currentEmployee == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave Requests"),
      ),

      // BODY
      body: LeaveRequestList(isSupervisor: isSupervisor, authCtrl: authController),

      // FLOATING ACTION BUTTON TO ADD NEW LEAVE ONLY FOR EMPLOYEE
      floatingActionButton: authController.currentEmployee != null ? FloatingActionButton(
        onPressed: () {
          leaveController.resetFields();
          Get.dialog(LeaveRequestDialog());
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ) : SizedBox(),
    );
  }
}

