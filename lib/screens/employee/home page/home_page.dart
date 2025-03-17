import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/current_date_time.dart';
import 'components/timing_info_row.dart';
import 'components/check_in_check_out_button.dart';
import 'components/employee_drawer.dart';
import 'components/greet_profile_message.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            // GREET NAME AND PROFILE
            GreetProfileMessage(),

            // CURRENT DATE TIME AND WEEK OF DAY AND MONTH
            CurrentDateTime(),

            Spacer(),

            // CIRCLE BUTTON
            CheckInCheckOutButton(),

            Spacer(),

            // TIMING INFORMATION
            TimingInfoRow(),

            Spacer(),
          ],
        ),
      ),

      // DRAWER
      drawer: EmployeeDrawer(),
    );
  }
}



