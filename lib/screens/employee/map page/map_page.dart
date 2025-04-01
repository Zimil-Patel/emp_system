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
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      // BODY
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.height * 0.2),
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // TIME
                    CurrentDateTime(),

                    // LOCATION STATUS
                    LocationStatus(),

                    // GOOGLE MAP
                    MapBox(),

                    if (false) TimingInfoRow(),

                    // CHECK IN, CHECK OUT, WORKING HOUR & ALERT MESSAGE
                    Obx(() => attendanceController.isInsideOfficeRange.value ? TimingInfoRow() : LocationAlertMessage()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
