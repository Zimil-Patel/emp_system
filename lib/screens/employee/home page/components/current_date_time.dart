import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CurrentDateTime extends StatefulWidget {
  const CurrentDateTime({
    super.key,
  });

  @override
  State<CurrentDateTime> createState() => _CurrentDateTimeState();
}

class _CurrentDateTimeState extends State<CurrentDateTime> {
  Timer? timer;

  @override
  void initState() {
    _updateDateTime();
    super.initState();
  }

  void _updateDateTime() {
    Timer.periodic(
      Duration(seconds: 1),
      (timer) => setState(
        () {
          this.timer = timer;
        },
      ),
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('hh:mm').format(DateTime.now()),
                style: TextStyle(
                  fontSize: 40.h,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "${DateFormat.s().format(DateTime.now()).padLeft(2, "0")} ${DateFormat('a').format(DateTime.now())}",
                  style: TextStyle(
                    fontSize: 20.h,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        // WEEK OF DAY
        Center(
          child: Text(
            DateFormat('EEEE, MMM dd').format(DateTime.now()),
            style: TextStyle(
              fontSize: 22.h,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
