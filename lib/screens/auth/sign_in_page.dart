import 'package:emp_system/screens/auth/components/loading_animation.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';
import '../employee/home page/home_page.dart';
import 'components/outlined_text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var txtEmail = TextEditingController();
    var txtPass = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // WELCOME TEXT
                Center(
                  child: Text(
                    'Welcome!',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 20.h),
                  ),
                ),

                // LOGO IMAGE
                Center(
                  child: Image.asset(
                    'assets/images/timeWork.png',
                    height: 240.h,
                    width: double.infinity,
                  ),
                ),

                SizedBox(height: 10.h),

                // EMAIL
                outlinedTextField(
                    hintText: 'Email',
                    icon: Icons.email,
                    controller: txtEmail),

                SizedBox(height: 10.h),

                // PASSWORD
                outlinedTextFieldForPassword(
                    hintText: 'Password',
                    icon: Icons.lock,
                    controller: txtPass),

                // FORGOT PASSWORD
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // showVerificationAlert(context);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: primaryColor, fontSize: 13.h),
                  ),
                ),

                // SIGN IN BUTTON
                Obx(
                      () => authController.isLoading.value
                      ? LoadingAnimation()
                      : Hero(
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
                            onPressed: () async {
                              final result =
                              await authController.signInEmployee(
                                  email: txtEmail.text,
                                  password: txtPass.text);
                              if (result) {
                                Get.offAll(() => HomePage());
                              }
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
                ),

                // DON'T HAVE ACCOUNT
                Row(
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                          color: Colors.grey.shade600, fontSize: 13.h),
                    ),

                    // SIGN UP
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Sign Up',
                        style:
                        TextStyle(color: primaryColor, fontSize: 13.h),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                // GOOGLE SIGN IN OPTION
                SizedBox(
                  height: 42.h,
                  width: double.infinity,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      final status =
                      await authController.handleGoogleSignIn(context);
                      if (status) {
                        Get.offAll(() => HomePage());
                      }
                    },
                    splashColor: primaryColor.withOpacity(0.2),
                    highlightColor: primaryColor.withOpacity(0.1),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Google icon
                          Image.asset('assets/images/google_logo.png',
                              height: 28),

                          SizedBox(width: 8.w),

                          Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.h,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
