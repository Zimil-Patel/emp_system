import 'package:emp_system/screens/auth/role_option_page.dart';
import 'package:emp_system/screens/employee/leave%20page/leave_page.dart';
import 'package:emp_system/screens/employee/profile%20page/profile_page.dart';
import 'package:emp_system/screens/employee/report%20page/report_page.dart';
import 'package:emp_system/screens/supervisor/stats%20page/stats_page.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget drawerItem({required String name, required IconData icon, required BuildContext context}){
  return InkWell(
    onTap: () async {

      Navigator.pop(context);

      if(name == "Logout"){
        await authController.signOut();
        Get.offAll(() => RoleOptionPage());
      }

      if(name == "Profile"){
        Get.to(() => ProfilePage());
      }

      if(name == "Reports"){
        Get.to(() => ReportPage());
      }

      if(name == "Leaves"){
        Get.to(() => LeavePage());
      }

      if(name == "Personal Stats"){
        if(authController.currentEmployee != null){
          await statsController.fetchStats(authController.currentEmployee!.email);
          Get.to(() => StatsPage(employee: authController.currentEmployee!));
        }
      }
    },
    // padding: EdgeInsets.zero,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 26.h,
            color: Colors.grey,
          ),

          SizedBox(width: 16.w,),
          Text(
            name,
            style: TextStyle(fontSize: 18.h, color: Colors.grey, fontFamily: 'VarelaRounded'),
          ),
        ],
      ),
    ),
  );
}