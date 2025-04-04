import 'package:emp_system/screens/supervisor/home%20page/components/supervisor_drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/app_theme.dart';

class SupervisorDrawer extends StatelessWidget {
  const SupervisorDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(),
      child: Column(
        children: [
          // DRAWER HEADER
          Container(
            alignment: Alignment.center,
            height: 160.h,
            color: primaryColor,
            child: Column(
              children: [
                SizedBox(height: 50.h),

                // PROFILE PICTURE
                CircleAvatar(
                  radius: 32.h,
                  backgroundColor: Color(0xff5b8956),
                  child: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                    size: 40.h,
                  ),
                ),

                SizedBox(
                  height: 8,
                ),

                // PROFILE NAME
                Text(
                  'Supervisor',
                  style: TextStyle(fontSize: 20.h, color: Colors.white),
                ),
              ],
            ),
          ),


          SizedBox(height: 10.h),

          // DRAWER ITEMS
          supervisorDrawerItem(name: 'Attendance', icon: Icons.calendar_month, context: context),
          supervisorDrawerItem(name: 'Late Comers', icon: Icons.access_time, context: context),
          supervisorDrawerItem(name: 'Early Leavers', icon: Icons.event_busy, context: context),
          supervisorDrawerItem(name: 'Leaves', icon: Icons.assignment, context: context),
          supervisorDrawerItem(name: 'Reports', icon: Icons.paste_sharp, context: context),
          supervisorDrawerItem(name: 'Employee List', icon: Icons.storage, context: context),
          supervisorDrawerItem(name: 'Logout', icon: Icons.logout, context: context),

        ],
      ),
    );
  }
}
