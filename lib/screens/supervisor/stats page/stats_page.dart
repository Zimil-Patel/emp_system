import 'package:cached_network_image/cached_network_image.dart';
import 'package:emp_system/core/model/employee_model.dart';
import 'package:emp_system/screens/supervisor/calendar%20page/calendar_page.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'components/detail_row.dart';
import 'components/percentage_indicator.dart';

class StatsPage extends StatelessWidget {
  final EmployeeModel employee;

  const StatsPage({super.key, required this.employee});

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
                    child: employee.photoUrl.isEmpty
                        ? Icon(
                            Icons.person_outline_rounded,
                            size: 30.h,
                            color: Colors.white,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: employee.photoUrl,
                              fit: BoxFit.cover,
                              useOldImageOnUrlChange: true,
                              height: 120,
                              width: 120,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 6.h),
                Center(
                  child: Text(
                    'Employee ID : ${employee.employeeId}',
                    style: TextStyle(fontSize: 16.h, color: Colors.white),
                  ),
                ),
                Center(
                  child: Text(
                    employee.name,
                    style: TextStyle(
                      fontSize: 18.h,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 12.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.h),
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: Obx(() => Text(
                                'Last ${statsController.totalDays} days',
                                style: TextStyle(fontSize: 14.h),
                              )),
                        ),
                      ),
                      SizedBox(width: 10),

                      // CALENDAR PAGE ICON
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          Get.to(() => CalendarPage(email: employee.email,));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // GRAPH VIEW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildPercentageIndicator(
                          calculatePercentage(statsController.lateCount.value,
                              statsController.totalDays.value),
                          'Late'),
                      buildPercentageIndicator(
                          calculatePercentage(statsController.absentCount.value,
                              statsController.totalDays.value),
                          'Absent'),
                      buildPercentageIndicator(
                          calculatePercentage(
                              statsController.earlyLeaveCount.value,
                              statsController.totalDays.value),
                          'Early Leave'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Leave Requests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  // LEAVE REQUESTS
                  CupertinoButton(
                    onPressed: (){},
                    padding: EdgeInsets.zero,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.h),
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Tap to view leave requests.',
                              style: TextStyle(fontSize: 14.h, fontFamily: 'VarelaRounded', color: Colors.black,),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_rounded, size: 14.h,),
                          ],
                        )),
                  ),

                  // ATTENDANCE DATA
                  SizedBox(height: 20),

                  buildDetailRow('Total Presents',
                      ' ${statsController.totalPresents} days'),
                  buildDetailRow('Late', ' ${statsController.lateCount} days'),
                  buildDetailRow('Early Leaves',
                      ' ${statsController.earlyLeaveCount} days'),
                  buildDetailRow(
                      'Absent', ' ${statsController.absentCount} days'),

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

String calculatePercentage(int count, int totalDays) {
  if (totalDays == 0) return "0";
  double percentage = (count / totalDays) * 100;
  return percentage.toStringAsFixed(1); // Format to 1 decimal place
}
