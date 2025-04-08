import 'package:emp_system/screens/employee/report%20page/components/outlined_text_field_for_report.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../theme/app_theme.dart';

class ReportDialog extends StatelessWidget {
  final String reportedByEmail;

  const ReportDialog({super.key, required this.reportedByEmail});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Report Issue / Incident",
              style: TextStyle(
                fontSize: 18.h,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: 12.h),

            // Type Switch
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      activeColor: primaryColor,
                      value: 'Incident',
                      groupValue: reportController.reportType.value,
                      onChanged: (val) =>
                          reportController.reportType.value = val!,
                    ),
                    Text('Incident', style: TextStyle(fontSize: 14.h)),
                    Radio<String>(
                      activeColor: primaryColor,
                      value: 'Issue',
                      groupValue: reportController.reportType.value,
                      onChanged: (val) =>
                          reportController.reportType.value = val!,
                    ),
                    Text('Issue', style: TextStyle(fontSize: 14.h)),
                  ],
                )),
            SizedBox(height: 10.h),

            // Title TextField
            outlinedTextFieldForReport(
              hintText: 'Title',
              controller: reportController.txtTitle,
            ),

            // Description TextField
            outlinedTextFieldForReport(
              hintText: 'Description',
              maxLine: 5,
              minLine: 1,
              controller: reportController.txtDescription,
              type: TextInputType.multiline,
            ),
            SizedBox(height: 20.h),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                reportController.addReport(
                    type: reportController.reportType.value,
                    title: reportController.txtTitle.text,
                    description: reportController.txtDescription.text,
                    reportedBy: reportedByEmail);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                minimumSize: Size(double.infinity, 45.h),
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
