// Required packages
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

  final String googleApiKey = "AIzaSyBGv9znbx4hAdCp_6YK0-HO2XVKI4ZXALk";

  bool locationSaved = false;
  bool mapReady = false;

  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    print("🔥 initState() called");
    _loadUserLocation();
  }

  // ---------------- LOAD USER LOCATION ----------------
  Future<void> _loadUserLocation() async {
    print("➡️ _loadUserLocation() started");

    LocationPermission perm = await Geolocator.checkPermission();
    print("📌 Permission status: $perm");

    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
      print("📌 Requested permission: $perm");
    }

    Position pos = await Geolocator.getCurrentPosition();
    print("📍 User Position: ${pos.latitude}, ${pos.longitude}");

    _userLatLng = LatLng(pos.latitude, pos.longitude);
    _updateUserMarker();

    if (mapReady && mounted) {
      print("🎥 Moving camera to user...");
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_userLatLng!, 16),
      );
    }

    print("✔️ _loadUserLocation() ended");
  }

  // ---------------- SEND USER LOCATION ----------------
  Future<void> _sendUserLocation() async {
    print("➡️ _sendUserLocation() started");

    if (_userLatLng == null) {
      print("❌ User location is NULL");
      return;
    }

    final res = await http.post(
      Uri.parse(updateApi),
      body: {
        "user": userId,
        "userLatitude": _userLatLng!.latitude.toString(),
        "userLongitude": _userLatLng!.longitude.toString(),
        "serviceProvider": providerId,
      },
    );

    print("📡 Update API Status: ${res.statusCode}");
    print("📡 Update API Response: ${res.body}");

    if (!mounted) return;
    setState(() => locationSaved = true);

    _startLiveTracking();
    print("✔️ _sendUserLocation() ended");
  }

  // ---------------- TIMER START ----------------
  void _startLiveTracking() {
    print("⏳ Starting live tracking...");
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      print("⏱️ TIMER TICK");
      if (!mounted) return;
      _fetchBothLocations();
    });
  }

  // ---------------- FETCH USER + PROVIDER ----------------
  Future<void> _fetchBothLocations() async {
    print("\n➡️ _fetchBothLocations() started");

    final r = await http.post(
      Uri.parse(getApi),
      body: {"user": userId, "serviceProvider": providerId},
    );

    print("🌍 Get API Status: ${r.statusCode}");
    print("🌍 Get API Response: ${r.body}");

    if (r.statusCode != 200) return;

    final data = jsonDecode(r.body);

    // USER
    if (data["user"] != null) {
      print("📌 Backend User Location Found");
      _userLatLng = LatLng(
        double.parse(data["user"]["latitude"].toString()),
        double.parse(data["user"]["longitude"].toString()),
      );
      _updateUserMarker();
    } else {
      print("❌ User data NULL");
    }

    // PROVIDER
    if (data["serviceprovider"] != null) {
      print("📌 Backend Provider Location Found");
      _providerLatLng = LatLng(
        double.parse(data["serviceprovider"]["latitude"].toString()),
        double.parse(data["serviceprovider"]["longitude"].toString()),
      );
      _updateProviderMarker();
    } else {
      print("❌ Provider data NULL");
    }

    // DRAW ROUTE
    if (_userLatLng != null && _providerLatLng != null) {
      print("🛣️ Drawing Route...");
      _fitBounds(_userLatLng!, _providerLatLng!);

      List<LatLng> route = await _getPolylineRoute(
        _userLatLng!,
        _providerLatLng!,
      );

      if (!mounted) return;
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

      print("✔️ Route Polyline Points: ${route.length}");
    }

    print("✔️ _fetchBothLocations() ended");
  }

  // ---------------- GOOGLE DIRECTIONS API ----------------
  Future<List<LatLng>> _getPolylineRoute(LatLng start, LatLng end) async {
    print("➡️ Calling Directions API...");

    final String url =
        "https://maps.googleapis.com/maps/api/directions/json?"
        "origin=${start.latitude},${start.longitude}"
        "&destination=${end.latitude},${end.longitude}"
        "&mode=driving"
        "&key=$googleApiKey";

    print("🔗 URL: $url");

    final res = await http.get(Uri.parse(url));
    print("📡 Directions API Status: ${res.statusCode}");

    final data = jsonDecode(res.body);

    if (data["routes"]?.isEmpty ?? true) {
      print("❌ No routes found");
      return [];
    }

    print("✔️ Polyline data found");
    String encoded = data["routes"][0]["overview_polyline"]["points"];
    return _decodePolyline(encoded);
  }

  // ---------------- DECODE POLYLINE ----------------
  List<LatLng> _decodePolyline(String encoded) {
    print("➡️ Decoding Polyline...");
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

    print("✔️ Polyline decoded: ${poly.length} points");
    return poly;
  }

  // ---------------- UPDATE USER MARKER ----------------
  void _updateUserMarker() {
    print("➡️ Updating User Marker...");
    if (_userLatLng == null || !mounted) return;

    _userMarker = Marker(
      markerId: const MarkerId("user"),
      position: _userLatLng!,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    if (mounted) setState(() {});
  }

  // ---------------- UPDATE PROVIDER MARKER ----------------
  void _updateProviderMarker() {
    print("➡️ Updating Provider Marker...");
    if (_providerLatLng == null || !mounted) return;

    _providerMarker = Marker(
      markerId: const MarkerId("provider"),
      position: _providerLatLng!,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    if (mounted) setState(() {});
  }

  // ---------------- FIT CAMERA ----------------
  Future<void> _fitBounds(LatLng a, LatLng b) async {
    print("➡️ fitBounds() Called");

    if (!mounted || _mapController == null) return;

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

      await _mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 70),
      );

      print("✔️ Camera moved to fit bounds");
    } catch (e) {
      print("❌ fitBounds ERROR: $e");
    }
  }

  @override
  void dispose() {
    print("🛑 dispose() → Timer Cancelled");
    _timer?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("🖥️ build() called");

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
              print("🗺️ Map Created");
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
              onPressed: _sendUserLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                locationSaved ? "Location Saved ✔" : "Confirm Location",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
