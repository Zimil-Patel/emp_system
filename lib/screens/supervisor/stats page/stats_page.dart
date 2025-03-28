import 'package:emp_system/screens/supervisor/calendar%20page/calendar_page.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'components/detail_row.dart';
import 'components/percentage_indicator.dart';


class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            color: primaryColor,
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 32.h,
                    backgroundColor: Color(0xff5b8956),
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: 30.h,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Center(
                  child: Text(
                    'Employee ID : 123456',
                    style: TextStyle(fontSize: 16.h, color: Colors.white),
                  ),
                ),
                Center(
                  child: Text(
                    'Faius Mojumder Nahin',
                    style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.bold, color: Colors.white,),
                  ),
                ),
                SizedBox(height: 6.h),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Personal Statistics',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
            
            
                      // DAYS FILTER DATE
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          focusColor: primaryColor,
            
                          value: 'Last 14 days',
                          items: <String>['Last 14 days', 'Last 30 days']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {},
                          dropdownColor: Colors.white,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
            
                      // CALENDAR PAGE ICON
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          Get.to(() => CalendarPage());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // GRAPH VIEW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildPercentageIndicator('10', 'Late'),
                      buildPercentageIndicator('5', 'Absent'),
                      buildPercentageIndicator('5', 'Leaves'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Leave Requests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),


                  // LEAVE REQUESTS
                  DropdownButtonFormField<String>(
                    value: 'Tap to view leave requests',
                    items: <String>['Tap to view leave requests'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                    dropdownColor: Colors.white,
                    focusColor: primaryColor,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                      ),
                    ),
                  ),


                  // ATTENDANCE DATA
                  SizedBox(height: 20),


                  buildDetailRow('Total Presents', '12 days'),
                  buildDetailRow('Late', '2 days'),
                  buildDetailRow('Early Leaves', '2 days'),
                  buildDetailRow('Absent', '1 days'),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
