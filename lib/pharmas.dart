// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class PharmaScreen extends StatefulWidget {
  const PharmaScreen({super.key});

  @override
  _PharmaScreenState createState() => _PharmaScreenState();
}

class _PharmaScreenState extends State<PharmaScreen> {
  String address = '';
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final String apiKey =
      'AIzaSyC6QVuHn3P9yhOGCJXB24SWDpGjLx8NNQ0'; // Replace 'YOUR_API_KEY' with your actual API key

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestLocationPermission();
    });
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, proceed with accessing location
      loadData();
    } else if (status.isDenied) {
      // Permission denied, show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Location permission is required to use this feature.')),
      );
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings
      openAppSettings();
    }
  }

  loadData() async {
    try {
      final Position position = await _getUserCurrentLocation();
      final LatLng userLocation = LatLng(position.latitude, position.longitude);
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      final add = placemarks.first;
      address =
          "${add.locality} ${add.administrativeArea} ${add.subAdministrativeArea} ${add.country}";

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(userLocation, 14));

      final List<Place> diagnosticLabs = await _fetchNearbyDiagnosticLabs(
          position.latitude, position.longitude);
      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('UserLocation'),
            position: userLocation,
            infoWindow: const InfoWindow(
              title: 'Your Location',
            ),
          ),
        );
        _markers.addAll(diagnosticLabs.map((lab) => Marker(
              markerId: MarkerId(lab.id),
              position: LatLng(lab.latitude, lab.longitude),
              infoWindow: InfoWindow(
                title: lab.name,
                snippet: lab.address,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor
                  .hueBlue), // Custom marker icon for diagnostic labs
            )));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Position> _getUserCurrentLocation() async {
    LocationPermission permission;

    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle accordingly
      return Future.error('Location services are disabled.');
    }

    // Check the current permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request permission if it is denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle accordingly
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, handle accordingly
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When permissions are granted, get the current position
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<Place>> _fetchNearbyDiagnosticLabs(
      double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json'
          '?location=$latitude,$longitude'
          '&radius=4000' // 4km radius // types of places to search for
          '&keyword=pharmacy||drugstore||chemist||medical'
          '&strictbounds=true' // keyword to filter only diagnostic labs
          '&key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      return results.where((result) {
        // Only include if the place contains "hospital" in its name
        final name = result['name'].toString().toLowerCase();
        return name.contains('pharmacy') ||
            name.contains('drugstore') ||
            name.contains('chemist') ||
            name.contains('medical');
      }).map<Place>((result) {
        return Place(
          id: result['place_id'],
          name: result['name'],
          address: result['vicinity'],
          latitude: result['geometry']['location']['lat'],
          longitude: result['geometry']['location']['lng'],
        );
      }).toList();
    } else {
      throw Exception('Failed to fetch nearby diagnostic labs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pharmacies Near You',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(10, 78, 159, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: GoogleMap(
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0), // Modify this target if needed
                zoom: 1, // Modify the zoom level if needed
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}

class Place {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  Place({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

void main() {
  runApp(MaterialApp(
    home: PharmaScreen(),
  ));
}
