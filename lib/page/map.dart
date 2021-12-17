import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:location/location.dart';

//import 'package:gps/gps.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  late BitmapDescriptor pinLocationIcon;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(14.0204353, 100.528382),
    zoom: 14.4746,
  );
  Set<Marker> markersV = Set();
  // ignore: sdk_version_set_literal
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();



  Future<void> getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData.latitude); //!----------------- location คนกด
    print(_locationData.longitude); //!----------------- location คนกด
    // var latlng = await Gps.currentGps();
    // print(latlng.lat);
    // print(latlng.lng);
    try {
      final CameraPosition _kLake = CameraPosition(
          //bearing: 192.8334901395799, //หมุนจอ
          target: LatLng(double.parse(_locationData.latitude.toString()),
              double.parse(_locationData.longitude.toString())),
          // tilt: 59.440717697143555, // เอียง
          zoom: 19.151926040649414);

      setState(() {});

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
      // getLocationPoleNearME(position);
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    // setCustomMapPin();
  }

  // void setCustomMapPin() async {
  //   pinLocationIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(
  //         devicePixelRatio: 2,
  //       ),
  //       'assets/images/Pole_1-1.png');
  // }

  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(37.3797536, -122.1017334);

    // these are the minimum required values to set
    // the camera position
    CameraPosition initialLocation =
        CameraPosition(zoom: 16, bearing: 30, target: pinPosition);

    return GoogleMap(
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      rotateGesturesEnabled: true,
      myLocationEnabled: true,
      compassEnabled: true,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      markers: markersV,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        setState(() {
          // setState(() {
          //   _markers.add(Marker(
          //       markerId: MarkerId('<MARKER_ID>'),
          //       position: pinPosition,
          //       icon: pinLocationIcon));
          // });
          //  setMarker();
        });
      },
    );
  }
}
