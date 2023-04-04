import 'dart:async';

import 'package:geocoding/geocoding.dart' as geo_coder;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

late LocationData _currentPosition;
String _address = "";
late GoogleMapController mapController;
late Marker marker;
Location location = Location();
CameraPosition cameraPosition =
    const CameraPosition(target: LatLng(0, 0), zoom: 10.0);

LatLng initialcameraposition = const LatLng(0.5937, 0.9629);

Future<String> getLoc() async {
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return "null";
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return "null";
    }
  }
  String details = "";

  _currentPosition = await location.getLocation();

  DateTime now = DateTime.now();

  details += "";
  details += DateFormat('EEE d MMM kk:mm:ss ').format(now);

  initialcameraposition =
      LatLng(_currentPosition.latitude!, _currentPosition.longitude!);

  _getAddress(_currentPosition.latitude!, _currentPosition.longitude!)
      .then((value) {
    _address = value.first.thoroughfare ?? "";
  });
  details += "{}";
  details += "${_currentPosition.latitude} , ${_currentPosition.longitude}";
  details += "{}";
  details += _address;

  return details;
}

Future<List<geo_coder.Placemark>> _getAddress(double lat, double lang) async {
  List<geo_coder.Placemark> add =
      await geo_coder.placemarkFromCoordinates(lat, lang);
  return add;
}
