import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class UserTrackingPage extends StatefulWidget {
  const UserTrackingPage({super.key});

  @override
  State<UserTrackingPage> createState() => _UserTrackingPageState();
}

class _UserTrackingPageState extends State<UserTrackingPage> {
  GoogleMapController? _mapController;

  LatLng? _userLatLng;
  LatLng? _providerLatLng;

  Marker? _userMarker;
  Marker? _providerMarker;

  Timer? _timer;

  final String updateApi = "http://admin.qwikhom.ae/api/updateLocation";
  final String getApi = "http://admin.qwikhom.ae/api/getLocation";

  final String userId = "18";
  final String providerId = "9";

  // ⭐ SAME GOOGLE DIRECTIONS API KEY (from provider app)
  final String googleApiKey = "AIzaSyBGv9znbx4hAdCp_6YK0-HO2XVKI4ZXALk";

  bool locationSaved = false;
  bool mapReady = false;

  // ⭐ Polyline route set
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
  }

  // ---------------------------
  // LOAD USER LOCATION
  // ---------------------------
  Future<void> _loadUserLocation() async {
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }

    Position pos = await Geolocator.getCurrentPosition();

    _userLatLng = LatLng(pos.latitude, pos.longitude);
    _updateUserMarker();

    if (mapReady) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_userLatLng!, 16),
      );
    }
  }

  // ---------------------------
  // USER CONFIRMS LOCATION
  // ---------------------------
  Future<void> _sendUserLocation() async {
    if (_userLatLng == null) return;

    await http.post(
      Uri.parse(updateApi),
      body: {
        "user": userId,
        "userLatitude": _userLatLng!.latitude.toString(),
        "userLongitude": _userLatLng!.longitude.toString(),

        "serviceProvider": providerId,
        "serviceProviderLatitude": "",
        "serviceProviderLongitude": "",
      },
    );

    setState(() => locationSaved = true);

    _startLiveTracking();
  }

  // LIVE TRACKING TIMER
  void _startLiveTracking() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _fetchBothLocations();
    });
  }

  // ---------------------------
  // FETCH USER + PROVIDER LOCATION + ROUTE
  // ---------------------------
  Future<void> _fetchBothLocations() async {
    final r = await http.post(
      Uri.parse(getApi),
      body: {"user": userId, "serviceProvider": providerId},
    );

    if (r.statusCode != 200) return;

    final data = jsonDecode(r.body);

    // USER
    if (data["user"] != null) {
      _userLatLng = LatLng(
        double.parse(data["user"]["latitude"]),
        double.parse(data["user"]["longitude"]),
      );
      _updateUserMarker();
    }

    // PROVIDER
    if (data["serviceprovider"] != null) {
      _providerLatLng = LatLng(
        double.parse(data["serviceprovider"]["latitude"]),
        double.parse(data["serviceprovider"]["longitude"]),
      );
      _updateProviderMarker();
    }

    // ⭐ Draw route when both have valid coords
    if (_userLatLng != null && _providerLatLng != null) {
      _fitBounds(_userLatLng!, _providerLatLng!);

      List<LatLng> route = await _getPolylineRoute(
        _userLatLng!,
        _providerLatLng!,
      );

      setState(() {
        _polylines = {
          Polyline(
            polylineId: const PolylineId("route"),
            width: 5,
            color: Colors.blue,
            points: route,
          ),
        };
      });
    }
  }

  // ---------------------------
  // GOOGLE DIRECTIONS API CALL
  // ---------------------------
  Future<List<LatLng>> _getPolylineRoute(LatLng start, LatLng end) async {
    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?"
        "origin=${start.latitude},${start.longitude}"
        "&destination=${end.latitude},${end.longitude}"
        "&mode=driving"
        "&key=$googleApiKey";

    final res = await http.get(Uri.parse(url));
    final data = jsonDecode(res.body);

    List<LatLng> points = [];

    if (data["routes"]?.isNotEmpty ?? false) {
      String encoded = data["routes"][0]["overview_polyline"]["points"];
      points = _decodePolyline(encoded);
    }

    return points;
  }

  // Decode Polyline
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      poly.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return poly;
  }

  // UPDATE MARKERS
  void _updateUserMarker() {
    if (_userLatLng == null) return;

    _userMarker = Marker(
      markerId: const MarkerId("user"),
      position: _userLatLng!,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(title: "You"),
    );
    setState(() {});
  }

  void _updateProviderMarker() {
    if (_providerLatLng == null) return;

    _providerMarker = Marker(
      markerId: const MarkerId("provider"),
      position: _providerLatLng!,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: "Provider"),
    );
    setState(() {});
  }

  // FIT CAMERA
  Future<void> _fitBounds(LatLng a, LatLng b) async {
    try {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          min(a.latitude, b.latitude),
          min(a.longitude, b.longitude),
        ),
        northeast: LatLng(
          max(a.latitude, b.latitude),
          max(a.longitude, b.longitude),
        ),
      );

      _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));
    } catch (_) {}
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User — Track Provider")),

      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(19.9975, 73.7898),
              zoom: 12,
            ),
            markers: {
              if (_userMarker != null) _userMarker!,
              if (_providerMarker != null) _providerMarker!,
            },
            polylines: _polylines,
            myLocationEnabled: true,
            onMapCreated: (controller) {
              _mapController = controller;
              mapReady = true;

              if (_userLatLng != null) {
                controller.animateCamera(
                  CameraUpdate.newLatLngZoom(_userLatLng!, 15),
                );
              }
            },
          ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: _sendUserLocation,
              child: Text(
                locationSaved ? "Location Saved ✔" : "Confirm Location",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
