import 'package:emp_system/screens/auth/sign_in_page.dart';
import 'package:emp_system/screens/auth/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';

class SignInSignUpOptionPage extends StatelessWidget {
  const SignInSignUpOptionPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // COMPANY LOGO
              Image.asset(
                'assets/images/logo.png',
                width: 240.w,
                height: 240.h,
              ),

              SizedBox(height: 20.h),

              // SIGN IN BUTTON
              Hero(
                tag: 'signIn',
                child: SizedBox(
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
                      Get.to(() => SignInPage());
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 16.h,
              ),

              // SIGN UP BUTTON
              Hero(
                tag: 'signUp',
                child: Material(
                  child: SizedBox(
                    height: 42.h,
                    width: double.infinity,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Get.to(() => SignUpPage());
                      },
                      splashColor: primaryColor.withOpacity(0.2),
                      highlightColor: primaryColor.withOpacity(0.1),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: primaryColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.h,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
