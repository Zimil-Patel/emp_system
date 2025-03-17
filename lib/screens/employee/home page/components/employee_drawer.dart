import 'package:emp_system/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'drawer_item.dart';


class EmployeeDrawer extends StatelessWidget {
  const EmployeeDrawer({
    super.key,
  });

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
                  'Hello! Brian',
                  style: TextStyle(fontSize: 20.h, color: Colors.white),
                ),
              ],
            ),
          ),


          SizedBox(height: 10.h),

          // DRAWER ITEMS
          drawerItem(name: 'Profile', icon: Icons.person_outline_rounded, context: context),
          drawerItem(name: 'Issues', icon: Icons.paste_sharp, context: context),
          drawerItem(name: 'Incident', icon: Icons.event_note_sharp, context: context),
          drawerItem(name: 'Leaves', icon: Icons.card_travel, context: context),
          drawerItem(name: 'Change Password', icon: Icons.lock_outline_rounded, context: context),
          drawerItem(name: 'Logout', icon: Icons.logout, context: context),

        ],
      ),
    );
  }
}
