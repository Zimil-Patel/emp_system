import 'package:emp_system/screens/map%20page/components/lcoation_alert_message.dart';
import 'package:emp_system/screens/map%20page/components/location_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'components/map_box.dart';
import 'components/timing_info_row.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),

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
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // TIME
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Center(
                            child: Text(
                              DateFormat.jm().format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 40.h,
                                color: Colors.grey,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),

                        // WEEK OF DAY
                        Center(
                          child: Text(
                            DateFormat('EEEE, MMM dd').format(DateTime.now()),
                            style: TextStyle(
                              fontSize: 24.h,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // LOCATION STATUS
                    LocationStatus(),

                    // GOOGLE MAP
                    MapBox(),

                    // CHECK IN, CHECK OUT, WORKING HOUR
                    if(false) TimingInfoRow(),

                    // CURRENT LOCATION ADDRESS
                    if (true) LocationAlertMessage(),

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
