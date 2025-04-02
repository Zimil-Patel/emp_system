import 'package:emp_system/screens/supervisor/attendance%20page/attendance%20page.dart';
import 'package:emp_system/screens/supervisor/early%20leavers%20page/early_leavers_page.dart';
import 'package:emp_system/screens/supervisor/employee%20list%20page/employee_list_page.dart';
import 'package:emp_system/screens/supervisor/late%20comer%20page/late_comers_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../auth/role_option_page.dart';

Widget supervisorDrawerItem({required String name, required IconData icon, required BuildContext context}){
  return InkWell(
    onTap: () async {

      Navigator.pop(context);

      if(name == "Logout"){
        await authController.signOut();
        Get.offAll(() => RoleOptionPage());
      }

      if(name == "Attendance"){
        Get.to(() => AttendancePage());
      }

      if(name == "Employee List"){
        supervisorController.selectedDate.value = DateTime.now();
        Get.to(() => EmployeeListPage());
      }

      if(name == "Late Comers"){
        supervisorController.selectedDate.value = DateTime.now();
        Get.to(() => LateComersPage());
      }

      if(name == "Early Leavers"){
        supervisorController.selectedDate.value = DateTime.now();
        Get.to(() => EarlyLeaversPage());
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