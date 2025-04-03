import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants.dart';

class AttendanceRefreshButton extends StatelessWidget {
  const AttendanceRefreshButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        supervisorController
            .updateDate(supervisorController.selectedDate.value);
      },
      child: Icon(
        Icons.sync,
        size: 20.h,
        color: Colors.black,
      ),
    );
  }
}
