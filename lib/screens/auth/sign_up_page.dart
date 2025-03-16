import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              outlinedTextField(
                  hintText: 'Password', icon: Icons.lock, controller: txtPass),

              SizedBox(
                height: 20.h,
              ),

              // SIGN UP BUTTON
              Hero(
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
                    onPressed: () {
                      showVerificationAlert(context);
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
                  onTap: () {},
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
    );
  }
}

// SHOW RESET PASSWORD OPTION NOT AVAILABLE
showVerificationAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.h),
      ),
      title: Row(
        children: [
          Text('Sign Up Complete'),
          Spacer(),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: Colors.red.shade400,
                ),
              ),
              child: Icon(
                Icons.close,
                color: Colors.red.shade400,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // MAIL ICON
          Image.asset(
            'assets/images/email_logo.png',
            height: 40.h,
            width: 40.w,
          ),

          SizedBox(
            height: 20.h,
          ),

          // DIALOG MESSAGE
          Text('Wait for verification! After Verify you will get a email'),
        ],
      ),
    ),
  );
}
