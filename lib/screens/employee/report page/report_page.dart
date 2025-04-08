import 'package:emp_system/screens/employee/report%20page/components/report_dialog.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'components/report_card.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),

      // Body
      body: Obx(() {
        final reports = reportController.reports;

        if (reports.isEmpty) {
          return Center(
            child: Text("No Reports Yet", style: TextStyle(fontSize: 14.h, color: Colors.grey)),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(12.w),
          itemCount: reports.length,
          itemBuilder: (_, index) {
            final report = reports[index];
            return ReportCard(report: report);
          },
        );
      }),

      // Floating action button to adding new report
      floatingActionButton: authController.currentEmployee != null ? FloatingActionButton(
        onPressed: () {
          Get.dialog(ReportDialog(reportedByEmail: authController.currentEmployee!.email));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ) : SizedBox(),
    );
  }
}