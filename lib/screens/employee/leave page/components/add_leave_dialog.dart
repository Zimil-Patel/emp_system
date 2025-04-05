import 'package:emp_system/core/model/leave_model.dart';
import 'package:emp_system/screens/employee/report%20page/components/outlined_text_field_for_report.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/leave_controller.dart';
import '../../../../utils/constants.dart';

class LeaveRequestDialog extends StatefulWidget {
  const LeaveRequestDialog({super.key});

  @override
  State<LeaveRequestDialog> createState() => _LeaveRequestDialogState();
}

class _LeaveRequestDialogState extends State<LeaveRequestDialog> {
  final leaveController = Get.find<LeaveController>();

  final List<String> leaveTypes = ['Sick Leave', 'Casual Leave', 'Paid Leave'];

  Future<void> pickDateRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (range != null) {
      leaveController.fromDate = range.start;
      leaveController.toDate = range.end;
      leaveController.update(['fromToDate']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TITLE
            Text(
              "Request Leave",
              style: TextStyle(
                fontSize: 18.h,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: 12.h),

            // Leave Type Dropdown
            Obx(
              () => DropdownButtonFormField<String>(
                value: leaveController.selectedLeaveType.value,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: primaryColor)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                    // labelText: "Leave Type",
                    label: Text(
                      "Leave Type",
                      style: TextStyle(color: Colors.grey),
                    )),
                items: leaveTypes
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (val) =>
                    leaveController.selectedLeaveType.value = val!,
              ),
            ),

            SizedBox(height: 12.h),

            // Date Picker
            InkWell(
              onTap: pickDateRange,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<LeaveController>(
                      id: 'fromToDate',
                      builder: (controller) => Text(
                        controller.fromDate != null && controller.toDate != null
                            ? "${DateFormat.yMd().format(controller.fromDate!)} - ${DateFormat.yMd().format(controller.toDate!)}"
                            : "Select Leave Date Range",
                        style: TextStyle(fontSize: 14.h),
                      ),
                    ),
                    Icon(Icons.calendar_today, size: 18.h),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // Reason Field
            outlinedTextFieldForReport(
              controller: leaveController.txtReason,
              hintText: "Reason for leave",
              icon: Icons.edit_note,
              maxLine: 3,
            ),

            SizedBox(height: 16.h),

            ElevatedButton(
              onPressed: () => leaveController.addLeave(),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                minimumSize: Size(double.infinity, 40.h),
              ),
              child: Text("Submit",
                  style: TextStyle(fontSize: 14.h, color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
