import 'package:emp_system/screens/employee/report%20page/components/reslove_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/model/report_model.dart';
import '../../../../theme/app_theme.dart';
import '../../../../utils/constants.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    required this.report,
  });

  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Report Type and Status Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  report.type,
                  style: TextStyle(
                      fontSize: 14.h,
                      color: primaryColor,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: report.status == "Resolved"
                        ? Colors.green.shade100
                        : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    report.status,
                    style: TextStyle(
                      color: report.status == "Resolved"
                          ? Colors.green
                          : Colors.orange,
                      fontSize: 12.h,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: 6.h),
            // Title
            Text(
              report.title,
              style: TextStyle(fontSize: 14.h, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 4.h),
            // Description
            Text(
              report.description,
              style: TextStyle(fontSize: 14.h, color: Colors.grey[700]),
            ),

            SizedBox(height: 8.h),
            // Reported by email
            Text("By: ${report.reportedBy}", style: TextStyle(fontSize: 12.h)),


            SizedBox(height: 4.h),

            // Date and time
            Text(
              _formatDateTime(report.reportedDate),
              style: TextStyle(fontSize: 12.h, color: Colors.grey),
            ),

            // Resolution Info
            if (report.status == "Resolved" && report.resolutionDetails != null)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  "Resolution: ${report.resolutionDetails}",
                  style: TextStyle(fontSize: 12.h, color: Colors.green.shade700),
                ),
              ),

            // Only show "Resolve" button for supervisors if not resolved
            if (authController.currentEmployee == null &&
                report.status == "Pending")
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    showResolveDialog(report.id);
                  },
                  child: Text("Mark as Resolved", style: TextStyle(color: primaryColor)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

String _formatDateTime(DateTime dateTime) {
  return DateFormat("d MMM yy, h:m a").format(dateTime);
}
