import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),

            Center(
              child: Text(
                DateFormat.jm().format(DateTime.now()),
                style: TextStyle(
                  fontSize: 40.h,
                  color: Colors.grey,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

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

            Spacer(),

            // LOCATION STATUS
            Row(
              children: [
                Image.asset(
                  'assets/images/alert_logo.png',
                  height: 18.h,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Status: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.h,
                  ),
                ),
                Expanded(
                  child: Text(
                    'You are not in office range',
                    style: TextStyle(
                      color: Colors.red.shade400,
                      fontSize: 15.h,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // GOOGLE MAP
            SizedBox(
              height: 200.h,
              width: 280.h,
              child: Container(
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 20.h),

            // CURRENT LOCATION ADDRESS
            Row(
              children: [
                Image.asset(
                  'assets/images/location_logo.png',
                  height: 18.h,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RichText(
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Your Location: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.h,
                          ),
                        ),

                        TextSpan(
                          text: 'Block C, 24/A Tajmahal Road, (Ring Road, Near Shia Mosque, Dhaka 1207)',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Spacer(flex: 1),

            // CHECK IN, CHECK OUT, WORKING HOUR
            if(false) TimingInfoRow(),

            // CURRENT LOCATION ADDRESS
            if(true) Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Column(
                children: [
                  RichText(
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Note: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.h,
                          ),
                        ),

                        TextSpan(
                          text: 'Please go inside Office range then',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.h,
                          ),
                        ),
                      ],
                    ),
                  ),

                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){},
                    child: Text(
                      'try again!',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.red.shade400,
                        fontSize: 15.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
