import 'package:cached_network_image/cached_network_image.dart';
import 'package:emp_system/controllers/profile_controller.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GreetProfileMessage extends StatelessWidget {
  const GreetProfileMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<ProfileController>(
                builder: (controller) => Text(
                  'Hey! ${authController.currentEmployee!.name}',
                  style: TextStyle(fontSize: 24.h),
                ),
              ),
              Text(
                'Mark your today\'s attendance',
                style: TextStyle(fontSize: 14.h, color: Colors.black54),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 20.h,
          backgroundColor: Colors.grey.shade400,
          backgroundImage: AssetImage('assets/images/profile.png'),
          child: Obx(
                () => profileController.image.isEmpty ? Container() : ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: profileController.image.value,
                fit: BoxFit.cover,
                useOldImageOnUrlChange: true,
                height: 120,
                width: 120,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
