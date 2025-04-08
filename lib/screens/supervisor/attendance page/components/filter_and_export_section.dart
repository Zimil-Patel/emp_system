import 'package:emp_system/core/services/export_services.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_theme.dart';

class FilterAndExportSection extends StatelessWidget {

  final String? title;

  const FilterAndExportSection({
    super.key, this.title,
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
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: supervisorController.selectedDate.value,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                supervisorController.updateDate(pickedDate);
              }
            },
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
                  Obx(() => Text(DateFormat('dd MMM yyyy').format(supervisorController.selectedDate.value), style: TextStyle(color: Colors.black, fontFamily: 'VarelaRounded', fontSize: 14.h),)),
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
                  Obx(
                      () => Text(
                        "${supervisorController.employeeList.where((emp) => emp.isVerified == true).toList().length}",
                      style: TextStyle(fontSize: 14.h, color: Colors.green),
                    ),
                  ),
                ],
              ),


              // CSV / PDF
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () async {
                      await ExportServices.exportToCSV("records" ,title: title);
                    },
                    padding: EdgeInsets.zero,
                    child: Text(
                      "CSV",
                      style: TextStyle(
                        fontSize: 14.h,
                        fontFamily: "VarelaRounded",
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "|",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(width: 5),
                  CupertinoButton(
                    onPressed: () async {
                      await ExportServices.exportToPDF("records" ,title: title);
                    },
                    padding: EdgeInsets.zero,
                    child: Text(
                      "PDF",
                      style: TextStyle(
                        fontSize: 14.h,
                        fontFamily: "VarelaRounded",
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
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