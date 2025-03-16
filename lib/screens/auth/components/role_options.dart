import 'package:emp_system/screens/auth/sign_in_sign_up_options_page.dart';
import 'package:emp_system/screens/auth/supervisor_sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../theme/app_theme.dart';

class RoleOptions extends StatelessWidget {
  const RoleOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // EMPLOYEE
        RoleOptionButton(role: 'Employee'),

        // SUPERVISOR
        RoleOptionButton(role: 'Supervisor'),
      ],
    );
  }
}

class RoleOptionButton extends StatelessWidget {
  const RoleOptionButton({super.key, required this.role});

  final String role;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        if(role == 'Employee'){
          Get.to(() => SignInSignUpOptionPage());
        } else {
          Get.to(() => SupervisorSignInPage());
        }
      },
      child: CircleAvatar(
        radius: 50.h,
        backgroundColor: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [

              // ROLE LOGO
              AspectRatio(
                aspectRatio: 1.8,
                child: Image.asset('assets/images/${role.toLowerCase()}.png'),
              ),

              // ROLE NAME
              Text(
                role,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
