import 'package:emp_system/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupervisorLoginPage extends StatelessWidget {
  const SupervisorLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
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
              child: Image.asset('assets/images/timeWork.png'),
            ),
            
            TextField(
              cursorColor: primaryColor,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.grey.shade400),
                label: Text('Email', style: TextStyle(color: Colors.grey),),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
