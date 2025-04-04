import 'package:emp_system/screens/employee/report%20page/components/report_dialog.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),

      // Body
      body: Center(child: Text('NoData')),

      // Floating action button to adding new report
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(ReportDialog(reportedByEmail: authController.currentEmployee!.email));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
