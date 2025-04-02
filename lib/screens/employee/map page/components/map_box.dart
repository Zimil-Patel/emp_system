import 'dart:developer';

import 'package:emp_system/core/services/attendance_services.dart';
import 'package:emp_system/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../utils/constants.dart';
import 'geo_address.dart';

class MapBox extends StatefulWidget {
  const MapBox({super.key, required this.isCheckIn});

  final bool isCheckIn;

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  GoogleMapController? mapController;
  LatLng? currentLocation;
  final double officeRange = 200;

  @override
  void initState() {
    getCurrentLocation(widget.isCheckIn);
    super.initState();
  }

  Future<void> getCurrentLocation(bool isCheckIn) async {
    // GETTING PERMISSION
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    // GET CURRENT LOCATION
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });

    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLng(currentLocation!));
    }
    getAddress();
    final bool result = await AttendanceService().isWithinOfficeRange(position);
    attendanceController.isInsideOfficeRange.value = result;
    if (result) {
      log("In office");
      if (isCheckIn) {
        await attendanceController
            .checkInEmployee(authController.currentEmployee!.email);
      } else {
        await attendanceController
            .checkOutEmployee(authController.currentEmployee!.email);
      }
    } else {
      log("Not in office");
    }
  }

  Future<String?> getAddress() async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          currentLocation!.latitude, currentLocation!.longitude);
      Placemark place = placeMarks.first;

      attendanceController.currentAddress.value =
          "${place.name} ${place.street} ${place.locality} ${place.country} ${place.postalCode}";
    } catch (e) {
      // log("Error: $e");
      attendanceController.currentAddress.value = "Address not found";
    }

    return attendanceController.currentAddress.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // GOOGLE MAP
        SizedBox(
          height: 200.h,
          width: 280.h,
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.shade400,
            child: currentLocation == null
                ? CircularProgressIndicator(color: primaryColor,)
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: currentLocation!,
                      zoom: 15,
                    ),
                    circles: {
                      Circle(
                        circleId: CircleId('officeRange'),
                        center: officeLocation,
                        fillColor: Colors.blue.withOpacity(0.3),
                        radius: officeRange,
                        strokeColor: Colors.blue,
                        strokeWidth: 2,
                      ),
                    },
                    markers: {
                      Marker(
                        markerId: MarkerId('currentLocation'),
                        position: currentLocation!,
                      ),
                    },
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                    myLocationEnabled: true,
                  ),
          ),
        ),

        SizedBox(height: 20.h),

        // ADDRESS OF CURRENT LOCATION
        Obx(() =>
            GeoAddress(address: attendanceController.currentAddress.value)),
      ],
    );
  }
}
