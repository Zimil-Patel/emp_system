import 'package:emp_system/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';
import '../employee/home page/home_page.dart';
import 'components/loading_animation.dart';
import 'components/outlined_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var txtEmail = TextEditingController();
    var txtPass = TextEditingController();
    var txtName = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                // WELCOME TAGLINES
                Text(
                  'Welcome! "Your First Step to Smarter Attendance Starts Here."',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.h),
                ),

                SizedBox(height: 30.h),

                // NAME
                outlinedTextField(
                    hintText: 'Name', icon: Icons.person, controller: txtName),

                SizedBox(height: 10.h),

                // EMAIL
                outlinedTextField(
                    hintText: 'Email', icon: Icons.email, controller: txtEmail),

                SizedBox(height: 10.h),

                // PASSWORD
                outlinedTextFieldForPassword(
                    hintText: 'Password', icon: Icons.lock, controller: txtPass),

                SizedBox(
                  height: 20.h,
                ),

                // SIGN UP BUTTON
                Obx(
                  () => authController.isLoading.value
                      ? LoadingAnimation()
                      : Hero(
                          tag: 'signUp',
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
                                    await authController.signUpEmployee(
                                        txtName.text,
                                        txtEmail.text,
                                        txtPass.text,
                                        context);
                                if (result) {
                                  txtName.clear();
                                  txtEmail.clear();
                                  txtPass.clear();
                                }
                              },
                              child: Text(
                                'Sign Up',
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

                // ALREADY HAVE ACCOUNT
                Row(
                  children: [
                    Text(
                      'Already have account? ',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 13.h),
                    ),

                    // ALREADY HAVE ACCOUNT SIGN IN HERE
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: primaryColor, fontSize: 13.h),
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
