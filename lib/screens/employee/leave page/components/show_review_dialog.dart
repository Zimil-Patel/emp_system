import 'package:emp_system/screens/employee/report%20page/components/outlined_text_field_for_report.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showLeaveReviewDialog({
  required String leaveId,
  required String type,
  required String reason,
  required String fromDate,
  required String toDate,
}) {
  TextEditingController remarksController = TextEditingController();

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Text(
                "Review Leave",
                style: TextStyle(
                  fontSize: 18.h,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // BASIC DETAILS OF LEAVE
            _infoRow("Type", type),
            _infoRow("From", fromDate),
            _infoRow("To", toDate),
            _infoRow("Reason", reason),


            SizedBox(height: 10.h),
            Text("Status", style: TextStyle(fontSize: 14.h, fontWeight: FontWeight.bold)),
            SizedBox(height: 6.h),

            // STATUS APPROVE, PENDING
            Obx(
                () => Row(
                children: ['Approved', 'Rejected'].map((status) {
                  return Row(
                    children: [
                      Radio<String>(
                        value: status,
                        groupValue: leaveController.selectedStatus.value,
                        onChanged: (value) {
                          leaveController.selectedStatus.value = value!;
                        },
                        activeColor: primaryColor,
                      ),
                      Text(status, style: TextStyle(fontSize: 14.h)),
                    ],
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10.h),

            // OPTIONAL - REMARK TEXT FIELD
            outlinedTextFieldForReport(
              hintText: 'Remarks (optional)',
              controller: remarksController,
              icon: Icons.comment,
              type: TextInputType.text,
            ),
            SizedBox(height: 20.h),


            // CANCEL AND SUBMIT BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // CANCEL BUTTON
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text("Cancel", style: TextStyle(color: Colors.grey)),
                ),


                // UPDATE LEAVE REQUEST / SUBMIT
                ElevatedButton(
                  onPressed: () async {
                    Get.back();
                    await leaveController.reviewLeave(
                      leaveId: leaveId,
                      status: leaveController.selectedStatus.value,
                      remarks: remarksController.text.trim(),
                    );

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("Submit", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _infoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: RichText(
      text: TextSpan(
        text: "$label: ",
        style: TextStyle(color: Colors.black, fontSize: 14.h, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(fontWeight: FontWeight.normal),
          )
        ],
      ),
    ),
  );
}
