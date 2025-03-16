import 'package:emp_system/screens/auth/components/outlined_text_field.dart';
import 'package:emp_system/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupervisorSignInPage extends StatelessWidget {
  const SupervisorSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var txtEmail = TextEditingController();
    var txtPass = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WELCOME TAGLINES
              Text(
                'Welcome Back! \n"Your Workforce, Your Control"',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.h),
              ),
        
              // WORK TIME LOGO
              AspectRatio(
                aspectRatio: 1.h,
                child: Image.asset('assets/images/supervisorWork.png'),
              ),
        
              // EMAIL
              outlinedTextField(
                  hintText: 'Email', icon: Icons.email, controller: txtEmail),
        
              // PASSWORD
              outlinedTextField(
                  hintText: 'Password', icon: Icons.lock, controller: txtPass),
        
              // FORGOT PASSWORD
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ),


              SizedBox(height: 20.h),

              // SIGN IN BUTTON
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
                  onPressed: () {},
                  child: Text(
                    'Sign in',
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
        ),
      ),
    );
  }
}
