import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../theme/app_theme.dart';

class FilterAndExportSection extends StatelessWidget {
  const FilterAndExportSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Date Picker
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: (){},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: primaryColor,),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('18 Mar 2025', style: TextStyle(color: Colors.black, fontFamily: 'VarelaRounded', fontSize: 14.h),),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),


          // TOTAL EMPLOYEE AND CSV PDF
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [


              // TOTAL EMPLOYEE
              Row(
                children: [
                  Text(
                    "Total Employees: ",
                    style: TextStyle(fontSize: 14.h),
                  ),
                  Text(
                    "25",
                    style: TextStyle(fontSize: 14.h, color: Colors.green),
                  ),
                ],
              ),


              // CSV / PDF
              Row(
                children: [
                  Text(
                    "CSV",
                    style: TextStyle(
                      fontSize: 14.h,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "|",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "PDF",
                    style: TextStyle(
                      fontSize: 14.h,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}