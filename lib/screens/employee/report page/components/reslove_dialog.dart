import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../theme/app_theme.dart';
import '../../../../utils/constants.dart';
import '../../../auth/components/outlined_text_field.dart';

void showResolveDialog(String reportId) {
  TextEditingController reasonController = TextEditingController();

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //  TITLE
            Text("Resolve Report", style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),

            // INSTRUCTION
            Text("Add resolution details", style: TextStyle(fontSize: 14.h)),
            SizedBox(height: 12.h),

            // RESOLUTION COMMENT TEXT FIELD
            outlinedTextField(
              hintText: "Resolution details",
              controller: reasonController,
              icon: Icons.check_circle,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // CANCEL BUTTON
                TextButton(
                  child: Text("Cancel", style: TextStyle(color: Colors.grey, fontSize: 14.h)),
                  onPressed: () => Get.back(),
                ),
                SizedBox(width: 10.w),

                // RESOLVE SUBMIT BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("Resolve", style: TextStyle(fontSize: 14.h, color: Colors.white)),
                  onPressed: () async {
                    if (reasonController.text.trim().isNotEmpty) {
                      await reportController.markAsResolved(reportId, reasonController.text.trim());
                    } else {
                      Get.snackbar(
                        "Validation",
                        "Please enter resolution details",
                        backgroundColor: Colors.orange.shade700,
                        colorText: Colors.white,
                        icon: Icon(
                          Icons.warning_amber_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                        snackPosition: SnackPosition.TOP,
                        margin: EdgeInsets.all(12),
                        borderRadius: 8,
                        duration: Duration(seconds: 3),
                        shouldIconPulse:
                        false,
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
