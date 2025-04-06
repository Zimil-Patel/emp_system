import 'package:emp_system/controllers/auth_controller.dart';
import 'package:emp_system/screens/employee/leave%20page/components/show_review_dialog.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/model/leave_model.dart';

class LeaveRequestList extends StatelessWidget {
  final String? email;
  const LeaveRequestList({
    super.key,
    required this.isSupervisor,
    required this.authCtrl,
    this.email,
  });

  final bool isSupervisor;
  final AuthController authCtrl;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LeaveModel>>(
      stream: leaveController.getLeaveStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          ));
        }

        final allLeaves = snapshot.data ?? [];

        // Filtering leaves based on role and if role is employee showing current employee leave
        final leaves = isSupervisor
            ? email != null ? allLeaves.where((ele) => ele.email == email).toList() : allLeaves
            : allLeaves
                .where((e) => e.email == authCtrl.currentEmployee!.email)
                .toList();

        if (leaves.isEmpty) {
          return Center(
              child: Text(
            "No leave requests found.",
            style: TextStyle(fontSize: 14.h, color: Colors.grey),
          ));
        }

        return ListView.builder(
          padding: EdgeInsets.all(12.r),
          itemCount: leaves.length,
          itemBuilder: (context, index) {
            final leave = leaves[index];

            return LeaveRequestCard(leave: leave, isSupervisor: isSupervisor);
          },
        );
      },
    );
  }
}

class LeaveRequestCard extends StatelessWidget {
  const LeaveRequestCard({
    super.key,
    required this.leave,
    required this.isSupervisor,
  });

  final LeaveModel leave;
  final bool isSupervisor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.grey.shade50,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ListTile(
        title: Text(leave.email),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h),
            Text(
              "Employee ID: ${leave.employeeId}",
              style: TextStyle(fontSize: 13.h),
            ),
            SizedBox(height: 4.h),

            Text(
              "Name: ${leave.employeeName}",
              style: TextStyle(fontSize: 13.h),
            ),
            SizedBox(height: 4.h),

            // TYPE OF LEAVE
            Text(
              "${leave.leaveType} • ${DateFormat.yMMMd().format(leave.fromDate)} - ${DateFormat.yMMMd().format(leave.toDate)}",
              style: TextStyle(fontSize: 13.h),
            ),
            SizedBox(height: 4.h),

            // REASON FOR LEAVE
            Text("Reason: ${leave.reason}", style: TextStyle(fontSize: 13.h)),
            SizedBox(height: 4.h),

            // STATUS PENDING, APPROVED, REJECTED
            Text("Status: ${leave.status}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: leave.status == "Approved"
                      ? Colors.green
                      : leave.status == "Rejected"
                          ? Colors.red.shade400
                          : Colors.orange,
                )),

            // REMARK FORM WHO APPROVED LEAVE
            if (leave.remarks != null)
              if(leave.remarks!.isNotEmpty) Text("Remarks: ${leave.remarks}",
                  style: TextStyle(fontSize: 12.h)),
          ],
        ),
        trailing: isSupervisor && leave.status == "Pending"
            ? IconButton(
                icon: Icon(Icons.remove_red_eye, color: primaryColor),
                onPressed: () => showLeaveReviewDialog(
                  leaveId: leave.id,
                  type: leave.leaveType,
                  reason: leave.reason,
                  fromDate: DateFormat.yMMMd().format(leave.fromDate),
                  toDate: DateFormat.yMMMd().format(leave.toDate),
                ),
              )
            : null,
      ),
    );
  }
}
