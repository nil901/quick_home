import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/screen/dashboard/main_home_screen.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentLatLng;
  Marker? _marker;
  String _address = "Fetching location...";
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _addressDetailsController =
      TextEditingController();
  final TextEditingController _receiverController = TextEditingController(
    text: "Nilesh Pathak, 9130348515",
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndGetLocation());
  }

  Future<void> _checkAndGetLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    _updatePosition(LatLng(position.latitude, position.longitude));
  }

  Future<void> _updatePosition(LatLng latLng) async {
    setState(() {
      _currentLatLng = latLng;
      _marker = Marker(
        markerId: const MarkerId("selected-location"),
        position: latLng,
        draggable: true,
        onDragEnd: (newPos) => _updatePosition(newPos),
      );
    });

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 17),
        ),
      );
    }

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _address =
              "${place.name ?? ""}, ${place.locality ?? ""}, ${place.administrativeArea ?? ""}";
        });
      }
    } catch (e) {
      debugPrint("Reverse geocode failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// 🗺️ Google Map
            _currentLatLng == null
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLatLng!,
                    zoom: 17,
                  ),
                  onMapCreated: (controller) => _mapController = controller,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  markers: _marker != null ? {_marker!} : {},
                  onTap: (pos) => _updatePosition(pos),
                ),

            /// 🔍 Search Bar
            Positioned(
              top: 10,
              left: 15,
              right: 15,
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(12),
                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: _searchController,
                  googleAPIKey: "AIzaSyBGv9znbx4hAdCp_6YK0-HO2XVKI4ZXALk",
                  inputDecoration: const InputDecoration(
                    hintText: "Search for area, street name...",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.all(12),
                  ),
                  debounceTime: 400,
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (Prediction prediction) {
                    if (prediction.lat != null && prediction.lng != null) {
                      _updatePosition(
                        LatLng(
                          double.parse(prediction.lat!),
                          double.parse(prediction.lng!),
                        ),
                      );
                    }
                  },
                  itemClick: (Prediction prediction) {
                    _searchController.text = prediction.description ?? "";
                    _searchController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _searchController.text.length),
                    );
                  },
                ),
              ),
            ),

            /// 📍 Move pin label
            if (_currentLatLng != null)
              Positioned(
                top: MediaQuery.of(context).size.height / 2.4,
                left: MediaQuery.of(context).size.width / 2 - 120,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Move pin to your exact delivery location",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),

            if (_currentLatLng != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 45),
                  child: Icon(Icons.location_on, color: Colors.red, size: 45),
                ),
              ),

            Positioned(
              bottom: 300,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.my_location, color: Colors.red),
                  label: const Text(
                    "Use current location",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: _checkAndGetLocation,
                ),
              ),
            ),

            /// 🧾 Bottom Sheet
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Delivery details",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: kprimary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _address,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _addressDetailsController,
                        decoration: const InputDecoration(
                          labelText: "Address details*",
                          hintText: "E.g. Floor, House no.",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Receiver details for this address",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _receiverController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kprimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainHomeScreen(),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Address saved successfully!"),
                              ),
                            );
                          },
                          child: const Text(
                            "Save address",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
