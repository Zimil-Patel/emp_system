import 'package:emp_system/screens/auth/components/outlined_text_field.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    var txtDesignation = TextEditingController();
    var txtDepartment = TextEditingController();
    var txtTeamName = TextEditingController();
    var txtPhone = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),

      // BODY
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [

                  // PROFILE
                  SizedBox(
                    height: 80.h,
                    width: 80.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [

                        // PROFILE PHOTO
                        Center(
                          child: SizedBox(
                            height: 70.h,
                            width: 70.h,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.shade400,
                              child: Icon(Icons.person_outline_rounded, color: Colors.white, size: 36.h,),
                            ),
                          ),
                        ),

                        // UPDATE PROFILE ICON
                        Positioned(
                          right: 1,
                          bottom: 10,
                          child: CircleAvatar(
                            radius: 12.h,
                            backgroundColor: primaryColor,
                            child: Icon(
                              Icons.edit,
                              size: 14.h,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(width: 16.w,),

                  // DISPLAY NAME
                  Text('Brian', style: TextStyle(fontSize: 24.h,),),

                  SizedBox(height: 8.h),

                  // DESIGNATION
                  outlinedTextField(hintText: 'Designation', controller: txtDesignation,),
                  SizedBox(height: 10.h,),

                  // DEPARTMENT
                  outlinedTextField(hintText: 'Department', controller: txtDepartment,),
                  SizedBox(height: 10.h,),

                  // TEAM NAME
                  outlinedTextField(hintText: 'Team Name', controller: txtTeamName,),
                  SizedBox(height: 10.h,),

                  // PHONE NUMBER
                  outlinedTextField(hintText: 'Phone', controller: txtPhone,),
                  SizedBox(height: 20.h,),


                  // UPDATE BUTTON
                  SizedBox(
                    height: 42.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {

                      },
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
