import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
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
                  radius: 40,
                  backgroundColor: Color(0xff5b8956),
                  child: Obx(
                    () => profileController.image.isEmpty ?  Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                      size: 45,
                    ) : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: profileController.image.value,
                        fit: BoxFit.cover,
                        useOldImageOnUrlChange: true,
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 8,
                ),

                // PROFILE NAME
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('employees')
                      .doc(profileController.authController.currentEmployee?.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.exists) {
                      var data = snapshot.data!.data();
                      return Text(
                        'Hello! ${data?['name'] ?? 'N/A'}',
                        style: TextStyle(fontSize: 20.h, color: Colors.white),
                      );
                    } else {
                      return Text('Loading...', style: TextStyle(fontSize: 24.h));
                    }
                  },
                ),

              ],
            ),
          ),


          SizedBox(height: 10.h),

          // DRAWER ITEMS
          drawerItem(name: 'Profile', icon: Icons.person_outline_rounded, context: context),
          drawerItem(name: 'Reports', icon: Icons.paste_sharp, context: context),
          drawerItem(name: 'Leaves', icon: Icons.card_travel, context: context),
          drawerItem(name: 'Change Password', icon: Icons.lock_outline_rounded, context: context),
          drawerItem(name: 'Logout', icon: Icons.logout, context: context),

        ],
      ),
    );
  }
}
