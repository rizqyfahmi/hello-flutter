
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late GoogleMapController _controller;
  final Location _location = Location();

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
  }

  Future<void> _goToTheLake() async {
    _controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void getLocation() async {
    bool _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    PermissionStatus _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData locationData = await _location.getLocation();
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0), zoom: 15)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map"),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(target: LatLng(-6.121435, 106.774124), zoom: 14),
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (controller) {
          _controller = controller;
          // _location.onLocationChanged.listen((event) {
          //   print("listen: ${event.latitude ?? 0.0}, ${event.longitude ?? 0.0}");
          // });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.pin_drop),
        onPressed: () {
          getLocation();  
          // _goToTheLake();
        }
      ),
    );
  }
}
