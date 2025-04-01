import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'geo_address.dart';

class MapBox extends StatefulWidget {
  const MapBox({super.key});

  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  GoogleMapController? mapController;
  LatLng? currentLocation;
  final double officeRange = 200;
  String? currentAddress;

  // SACHIN
  final LatLng officeLocation = LatLng(21.084967, 72.881111);

  // BMU
  // final LatLng officeLocation = LatLng(21.139171, 72.793428);

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Future<void> getCurrentLocation() async {
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
  }

  Future<String?> getAddress() async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(currentLocation!.latitude, currentLocation!.longitude);
      Placemark place = placeMarks.first;

      currentAddress =
          "${place.name} ${place.street} ${place.locality} ${place.country} ${place.postalCode}";
    } catch (e) {
      // log("Error: $e");
      currentAddress = "Address not found";
    }

    return currentAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:  MainAxisAlignment.center,
      children: [
        // GOOGLE MAP
        SizedBox(
          height: 200.h,
          width: 280.h,
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey,
            child: currentLocation == null
                ? CircularProgressIndicator()
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
                    onMapCreated: (controller) {
                      mapController = controller;
                    },
                    myLocationEnabled: true,
                  ),
          ),
        ),

        SizedBox(height: 20.h),

        // ADDRESS OF CURRENT LOCATION
        FutureBuilder<String?>(
          future: getAddress(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return GeoAddress(address: "Fetching Location");
            }

            return GeoAddress(address: snapshot.data);
          },
        ),
      ],
    );
  }
}
