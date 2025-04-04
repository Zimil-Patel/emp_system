import 'package:emp_system/controllers/report_controller.dart';
import 'package:emp_system/screens/employee/report%20page/components/outlined_text_field_for_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../theme/app_theme.dart';

class ReportDialog extends StatelessWidget {
  final ReportController controller = Get.put(ReportController());
  final String reportedByEmail;

  ReportDialog({super.key, required this.reportedByEmail});

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
                      value: 'incident',
                      groupValue: controller.reportType.value,
                      onChanged: (val) => controller.reportType.value = val!,
                    ),
                    Text('Incident', style: TextStyle(fontSize: 14.h)),
                    Radio<String>(
                      activeColor: primaryColor,
                      value: 'issue',
                      groupValue: controller.reportType.value,
                      onChanged: (val) => controller.reportType.value = val!,
                    ),
                    Text('Issue', style: TextStyle(fontSize: 14.h)),
                  ],
                )),
            SizedBox(height: 10.h),

            // Title TextField
            outlinedTextFieldForReport(
              hintText: 'Title',
              controller: controller.titleController,
            ),

            // Description TextField
            outlinedTextFieldForReport(
              hintText: 'Description',
              maxLine: 5,
              minLine: 1,
              controller: controller.descriptionController,
              type: TextInputType.multiline,
            ),
            SizedBox(height: 20.h),

            // Submit Button
            ElevatedButton(
              onPressed: () {},
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
