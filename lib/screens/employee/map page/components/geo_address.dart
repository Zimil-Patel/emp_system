import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class GeoAddress extends StatelessWidget {
  const GeoAddress({
    super.key, this.address,
  });

  final String? address;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/location_logo.png',
            height: 18.h,
          ),

          SizedBox(
            width: 10,
          ),

          Flexible(
            child: RichText(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Your Location: ',
                    style: TextStyle(
                      fontFamily: 'VarelaRounded',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.h,
                    ),
                  ),

                  TextSpan(
                    text: address ?? 'Address not found',
                    style: TextStyle(
                      fontFamily: 'VarelaRounded',
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
    );
  }
}
