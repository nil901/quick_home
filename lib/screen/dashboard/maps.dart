import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quick_home/api_services/Providers.dart';
import 'package:quick_home/model/address_model.dart';
import 'package:quick_home/screen/dashboard/selected_address_screen.dart';

class DeliveryLocationPage extends ConsumerStatefulWidget {
  const DeliveryLocationPage({super.key});

  @override
  ConsumerState<DeliveryLocationPage> createState() =>
      _DeliveryLocationPageState();
}

class _DeliveryLocationPageState extends ConsumerState<DeliveryLocationPage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailsController = TextEditingController();

  GoogleMapController? mapController;
  LatLng? _currentPosition;
  String? _currentAddress;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  // 📍 Get current user location and address
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enable location services.")),
      );
      return;
    }

    // Check for permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission denied")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission permanently denied")),
      );
      return;
    }

    // ✅ Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    // ✅ Convert coordinates to human-readable address
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      String address =
          "${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}";
      setState(() {
        _currentAddress = address;
        addressController.text = address;
      });
    }

    // Move map camera
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_currentPosition!, 15),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE4F9FF),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Select Delivery Location",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search here",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 🗺 Google Map
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition ?? const LatLng(20.0059, 73.7910),
                    zoom: 14,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  markers: {
                    if (_currentPosition != null)
                      Marker(
                        markerId: const MarkerId("selected-location"),
                        position: _currentPosition!,
                      ),
                  },
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: ElevatedButton.icon(
                    onPressed: _determinePosition,
                    icon: const Icon(Icons.my_location, color: Colors.red),
                    label: const Text(
                      "Use current location",
                      style: TextStyle(color: Colors.red),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 📦 Delivery Details Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFE4F9FF),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Delivery details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on, color: Colors.blue),
                    hintText: "Fetching your location...",
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: addressDetailsController,
                  decoration: const InputDecoration(
                    hintText: "Address details*",
                    labelText: "E.g. floor, House no.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (addressController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select your location"),
                          ),
                        );
                        return;
                      }

                      final newAddress = Address(
                        id: DateTime.now().millisecondsSinceEpoch,
                        userId: 1,
                        addressDetails:
                            "${addressController.text}, ${addressDetailsController.text}",
                        isDefault: true,
                        user: User(
                          id: 1,
                          name: "Pritesh Pawar",
                          phone: "9999999999",
                        ),
                      );

                      final addressList = ref.read(addressProvider.notifier);
                      addressList.state = [...addressList.state, newAddress];

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectedMyAddress(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Save address",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
