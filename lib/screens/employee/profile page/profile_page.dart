import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../auth/components/outlined_text_field.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // PROFILE IMAGE + EDIT ICON
              GestureDetector(
                onTap: () async {
                  await profileController.pickImage();
                },
                child: SizedBox(
                  height: 100.h,
                  width: 100.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // PROFILE PHOTO
                      Obx(
                        () => CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade400,
                          child: profileController.image.isEmpty ? Icon(Icons.person_outline_rounded, color: Colors.white, size: 40.h) : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: profileController.image.value,
                              fit: BoxFit.cover,
                              useOldImageOnUrlChange: true,
                              height: 130,
                              width: 130,
                            ),
                          ),
                        ),
                      ),

                      // EDIT ICON
                      Positioned(
                        right: 5,
                        bottom: 10,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: primaryColor,
                          child: Icon(Icons.edit, size: 18, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              // STREAMED EMPLOYEE NAME
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('employees')
                    .doc(profileController.authController.currentEmployee?.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.exists) {
                    var data = snapshot.data!.data();
                    return Text(
                      data?['name'] ?? 'Employee',
                      style: TextStyle(fontSize: 24.h, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return Text('Loading...', style: TextStyle(fontSize: 24.h));
                  }
                },
              ),

              SizedBox(height: 5.h),

              // EMPLOYEE ID DISPLAY
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('employees')
                    .doc(profileController.authController.currentEmployee?.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.exists) {
                    var data = snapshot.data!.data();
                    return Text(
                      'ID: ${data?['employee_id'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 14.h, color: Colors.grey),
                    );
                  } else {
                    return Text('Loading...', style: TextStyle(fontSize: 24.h));
                  }
                },
              ),

              SizedBox(height: 20.h),

              // NAME
              Obx(() => outlinedTextField(
                hintText: 'Name',
                icon: Icons.person,
                controller: profileController.txtName,
                enabled: profileController.isEditing.value,
              )),
              SizedBox(height: 10.h),

              // DESIGNATION
              Obx(() => outlinedTextField(
                hintText: 'Designation',
                icon: Icons.design_services,
                controller: profileController.txtDesignation,
                enabled: profileController.isEditing.value,
              )),
              SizedBox(height: 10.h),

              // DEPARTMENT
              Obx(() => outlinedTextField(
                hintText: 'Department',
                icon: Icons.work,
                controller: profileController.txtDepartment,
                enabled: profileController.isEditing.value,
              )),
              SizedBox(height: 10.h),

              // TEAM NAME
              Obx(() => outlinedTextField(
                hintText: 'Team Name',
                icon: Icons.group,
                controller: profileController.txtTeamName,
                enabled: profileController.isEditing.value,
              )),
              SizedBox(height: 10.h),

              // PHONE NUMBER
              Obx(() => outlinedTextField(
                hintText: 'Phone',
                icon: Icons.phone,
                type: TextInputType.phone,
                controller: profileController.txtPhone,
                enabled: profileController.isEditing.value,
              )),
              SizedBox(height: 20.h),

              // BUTTONS
              Obx(() => SizedBox(
                height: 42.h,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    backgroundColor: primaryColor,
                  ),
                  onPressed: profileController.isEditing.value
                      ? profileController.updateProfile
                      : profileController.toggleEditing,
                  child: Text(
                    profileController.isEditing.value ? 'Update' : 'Edit Profile',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.h, color: Colors.white),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
