import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../home page/components/current_date_time.dart';
import 'components/lcoation_alert_message.dart';
import 'components/location_status.dart';
import 'components/map_box.dart';
import '../home page/components/timing_info_row.dart';

class MapPage extends StatelessWidget {
  final bool isCheckIn;
  const MapPage({super.key, required this.isCheckIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      // BODY
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TIME
                CurrentDateTime(),

                SizedBox(height: 30.h),

                // LOCATION STATUS
                LocationStatus(),

                SizedBox(height: 10.h),

                // GOOGLE MAP
                MapBox(isCheckIn: isCheckIn,),

                // CHECK IN, CHECK OUT, WORKING HOUR & ALERT MESSAGE
                Obx(() => attendanceController.isInsideOfficeRange.value ? TimingInfoRow() : LocationAlertMessage()),

                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
