import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quick_home/screen/dashboard/main_home_screen.dart';

class DeliveryLocationPage extends StatefulWidget {
  const DeliveryLocationPage({super.key});

  @override
  State<DeliveryLocationPage> createState() => _DeliveryLocationPageState();
}

class _DeliveryLocationPageState extends State<DeliveryLocationPage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  GoogleMapController? mapController;

  // Default location = Nashik
  final LatLng _initialPosition = const LatLng(20.0059, 73.7910);

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
          // 🔹 Search Bar
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

          // 🔹 Google Map
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  markers: {
                    Marker(
                      markerId: const MarkerId("selected-location"),
                      position: _initialPosition,
                    ),
                  },
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Add "use current location" logic here
                    },
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

          // 🔹 Delivery Details Card
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
                    hintText: "Tidake colony, Durwankur Lawns, Nashik",
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: addressController,
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainHomeScreen(),
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
