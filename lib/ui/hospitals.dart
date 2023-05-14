// ignore_for_file: library_private_types_in_public_api
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'lobby.dart';

class Hospitals extends StatefulWidget {
  const Hospitals({super.key});

  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  final Map<String, Marker> _markers = {};
  LatLng? _currentPosition;
  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next step is to inform the user and guide
        // them to the settings page
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return;
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _getNearbyPlaces(_currentPosition);
    });
  }

  void _getNearbyPlaces(LatLng? center) async {
    if (center == null) return;

    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${center.latitude},${center.longitude}&radius=10000&type=hospital&key=AIzaSyDytj5l8LUaEZxcvCdV9LK3WDhIB3GiZO8';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _updateMarkers(data['results']);
    } else {
      throw Exception('An error occurred getting nearby places');
    }
  }

  void _updateMarkers(List<dynamic> data) {
    setState(() {
      _markers.clear();
      for (final place in data) {
        final marker = Marker(
          markerId: MarkerId(place['place_id']),
          position: LatLng(place['geometry']['location']['lat'],
              place['geometry']['location']['lng']),
          infoWindow: InfoWindow(
            title: place['name'],
            snippet: place['vicinity'],
          ),
        );
        _markers[place['place_id']] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _currentPosition == null
        ? const CircularProgressIndicator(
            value: 0.3,
            color: Colors.greenAccent,
            backgroundColor: Colors.grey,
          )
        : Scaffold(
            // <-- Scaffold widget added
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 16,
                  ),
                  markers: _markers.values.toSet(),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  indoorViewEnabled: true,
                  buildingsEnabled: true,
                  mapToolbarEnabled: true,
                  mapType: MapType.normal,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Get.off(() => Lobby());
                        },
                        icon: const Icon(Icons.widgets_outlined, size: 40),
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
