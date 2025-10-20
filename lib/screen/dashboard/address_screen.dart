// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:quick_home/color/colors.dart';
// import 'package:quick_home/model/address_model.dart';
// import 'package:quick_home/screen/dashboard/payment_screen.dart';
// import 'package:quick_home/util/custom_app_bar.dart';

// class AddressScreen extends StatefulWidget {
//   const AddressScreen({super.key, required Address address});

//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   bool isHomeSelected = true;
//   // GoogleMapController? mapController;

//   // final LatLng _center = const LatLng(20.011, 73.790);

//   // void _onMapCreated(GoogleMapController controller) {
//   //   mapController = controller;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kwhite,
//       appBar: CustomAppBar(title: "Address"),
//       body: Column(
//         children: [

      
      
//           // // Map section (untouched)
//           // SizedBox(
//           //   height: 250,
//           //   child: GoogleMap(
//           //     onMapCreated: _onMapCreated,
//           //     initialCameraPosition: CameraPosition(
//           //       target: _center,
//           //       zoom: 17.0,
//           //     ),
//           //     myLocationEnabled: true,
//           //     myLocationButtonEnabled: false,
//           //     zoomControlsEnabled: false,
//           //     liteModeEnabled: false,
//           //     mapToolbarEnabled: false,
//           //   ),
//           // ),
//           SizedBox(
//             height: 250,
           
//           ),
      
//           // Address + Form (scrollable)
//           Expanded(
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Address + Change button in same row
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children:  [
//                             Text(
//                               "Mumbai Naka",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: kprimary
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               "Mumbai Naka, Madhav Nagar, Tidke Colony, Nashik, Maharashtra 422002, India",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: const Text("Change"),
//                       ),
//                     ],
//                   ),
      
//                   const Divider(),
      
//                   // Form fields
//                   _buildTextField("House/Flat Number*"),
//                   const SizedBox(height: 12),
//                   _buildTextField("Landmark (Optional)"),
//                   const SizedBox(height: 12),
//                   _buildTextField("Name"),
//                   const SizedBox(height: 16),
      
//                   // Save As buttons
//                   Row(
//                     children: [
//                       ChoiceChip(
//                         label: const Text("Home"),
//                         selected: isHomeSelected,
//                         onSelected: (val) {
//                           setState(() => isHomeSelected = val);
//                         },
//                       ),
//                       const SizedBox(width: 12),
//                       ChoiceChip(
//                         label: const Text("Other"),
//                         selected: !isHomeSelected,
//                         onSelected: (val) {
//                           setState(() => isHomeSelected = !val);
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
      
//           // Bottom Button
//           SafeArea(
//             child: Center(
//               child: Container(
//                 width: 350, // fixed width
//                 height: 44, // fixed height
//                 margin: const EdgeInsets.symmetric(vertical: 12),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     _showSlotSelector(context);
//                   },
      
//                   style: ElevatedButton.styleFrom(
//                     // backgroundColor: Colors.grey.shade300,
//                     // foregroundColor: Colors.black54,
//                     backgroundColor: HexColor("#3A3A3A"),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10), // radius 10px
//                     ),
//                     elevation: 0,
//                   ),
//                   child: Text(
//                     "Save",
//                     style: TextStyle(fontSize: 14, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Reusable text field
//   Widget _buildTextField(String label) {
//     return TextField(
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 12,
//           vertical: 10,
//         ),
//       ),
//     );
//   }
// }

// void _showSlotSelector(BuildContext context) {
//   showModalBottomSheet(
//     backgroundColor: Colors.white,
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//     ),
//     isScrollControlled: true,
//     builder: (context) {
//       int selectedTime = 1; // index for selected time button
//       int selectedDate = 0; // index for selected date button

//       List<String> times = [
//         "03:30 PM",
//         "04:30 PM",
//         "05:00 PM",
//         "05:30 PM",
//         "06:30 PM",
//         "07:00 PM",
//       ];

//       List<String> dates = ["Fri, 26", "Sat, 27", "Sun, 28"];

//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Padding(
//             padding: EdgeInsets.only(
//               left: 16,
//               right: 16,
//               top: 16,
//               bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: Icon(Icons.close),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Your Qwik Slot - Choose Date & Time",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                       color: Color(0xFF353535),
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Date selection with custom layout
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate(dates.length, (i) {
//                     bool isSelected = selectedDate == i;
//                     return GestureDetector(
//                       onTap: () => setState(() => selectedDate = i),
//                       child: Container(
//                         width: 108, // fixed width
//                         height: 46, // fixed height
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: isSelected ? Color(0xFFD9D9D9) : Colors.white,
//                           borderRadius: BorderRadius.circular(
//                             5,
//                           ), // border-radius 5
//                           border: Border.all(
//                             color: HexColor("#B4B4B4"), // #353535
//                             width: 1,
//                           ),
//                         ),
//                         child: Text(
//                           dates[i],
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),

//                 SizedBox(height: 24),

//                 // Time selection (can also customize similar to dates)
//                 Wrap(
//                   spacing: 12,
//                   runSpacing: 12,
//                   children: List.generate(times.length, (i) {
//                     bool isSelected = selectedTime == i;
//                     return ChoiceChip(
//                       label: Text(times[i]),
//                       selected: isSelected,
//                       onSelected: (val) {
//                         setState(() => selectedTime = i);
//                       },
//                       selectedColor: Color(0xFFD9D9D9),
//                       backgroundColor: Colors.white,
//                       labelStyle: TextStyle(color: Colors.black),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         side: BorderSide(color: Color(0xFF353535), width: 1),
//                       ),
//                     );
//                   }),
//                 ),

//                 SizedBox(height: 32),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 48,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => PaymentScreen(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       "Proceed to Payment",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/util/custom_app_bar.dart';
import '../../model/address_model.dart';
import '../../prefs/app_preference.dart';
import '../../prefs/preferences_keys.dart';
import '../../provide/add_address.dart';

class AddressScreen extends ConsumerStatefulWidget {
  final Address? address;
  const AddressScreen({super.key, this.address});

  @override
  ConsumerState<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends ConsumerState<AddressScreen> {
  // 🌍 Map and location vars
  GoogleMapController? _mapController;
  LatLng? _currentLatLng;
  Marker? _marker;
  String _address = "Fetching location...";
  bool _isFromSearch = false;

  final TextEditingController _searchController = TextEditingController();

  // 📦 Form fields
  final TextEditingController houseController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isHomeSelected = true;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndGetLocation());
  // }
  @override
  void initState() {
    super.initState();

    if (widget.address != null) {
      // pre-fill for edit
      houseController.text = widget.address!.addressDetails ?? '';
      nameController.text = widget.address!.contactDetails ?? '';
      isHomeSelected = widget.address!.type == 'home';
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndGetLocation());
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _searchController.dispose();
    houseController.dispose();
    nameController.dispose();
    super.dispose();
  }

  // 📍 Check & get location
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

  // 🔁 Update map + address on drag/tap
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
        CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 17)),
      );
    }

    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        if (!_isFromSearch) {
          String readable = [
            place.street,
            place.subLocality,
            place.locality,
            place.administrativeArea,
          ].where((e) => e != null && e.isNotEmpty).join(", ");

          setState(() {
            _address = readable.isNotEmpty ? readable : "Unknown location";
          });
        } else {
          // Reset flag once used
          _isFromSearch = false;
        }

      }
    } catch (e) {
      debugPrint("Reverse geocode failed: $e");
    }
  }

  void _saveAddress() {
    final pref = AppPreference();
    String contactDetails = nameController.text.trim();
    final addressDetails = "${houseController.text.trim()}, $_address";
    final type = isHomeSelected ? 'home' : 'other';

    if (contactDetails.isEmpty) {
      final fallbackName = pref.getString(PreferencesKey.name);
      final fallbackPhone = pref.getString(PreferencesKey.phone);
      contactDetails = "$fallbackName, $fallbackPhone";
    }

    if (houseController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter house or flat number")),
      );
      return;
    }

    if (widget.address != null) {
      // EDIT
      ref.read(editAddressProvider.notifier).editAddress(
        addressId: widget.address!.id!,
        contactDetails: contactDetails,
        addressDetails: addressDetails,
        type: type,
        isDefault: 1,
      );
    } else {
      // ADD
      ref.read(addAddressProvider.notifier).addAddress(
        contactDetails: contactDetails,
        addressDetails: addressDetails,
        type: type,
        isDefault: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressState = ref.watch(addAddressProvider);

      // ref.listen<AsyncValue<String>>(addAddressProvider, (previous, next) {
      //   next.when(
      //     data: (msg) {
      //       if (msg.isNotEmpty) {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(content: Text(msg)),
      //         );
      //         Navigator.pop(context, true); // 👈 Pop after successful add
      //       }
      //     },
      //     loading: () {},
      //     error: (e, st) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(content: Text(e.toString())),
      //       );
      //     },
      //   );
      // });
    ref.listen<AsyncValue<String>>(addAddressProvider, (previous, next) {
      next.when(
        data: (msg) {
          if (msg.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg)),
            );
            Navigator.pop(context, true);
          }
        },
        loading: () {},
        error: (e, st) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        },
      );
    });


    // ✅ Listen for Edit Address Success
    //   ref.listen<AsyncValue<String>>(editAddressProvider, (previous, next) {
    //     next.when(
    //       data: (msg) {
    //         if (msg.isNotEmpty) {
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(content: Text(msg)),
    //           );
    //           Navigator.pop(context, true); // 👈 Pop after successful edit
    //         }
    //       },
    //       loading: () {},
    //       error: (e, st) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(content: Text(e.toString())),
    //         );
    //       },
    //     );
    //   });

    ref.listen<AsyncValue<String>>(editAddressProvider, (previous, next) {
      next.when(
        data: (msg) {
          if (msg.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg)),
            );
            Navigator.pop(context, true);
          }
        },
        loading: () {},
        error: (e, st) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        },
      );
    });



    return Scaffold(
      backgroundColor: kwhite,
      appBar: CustomAppBar(title: "Add Address"),
      body: SafeArea(
        child: Stack(
          children: [
            /// 🗺 MAP SECTION
            _currentLatLng == null
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
              initialCameraPosition:
              CameraPosition(target: _currentLatLng!, zoom: 17),
              onMapCreated: (controller) => _mapController = controller,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: _marker != null ? {_marker!} : {},
              onTap: (pos) => _updatePosition(pos),
            ),

            /// 🔍 SEARCH BAR
            Positioned(
              top: 10,
              left: 15,
              right: 15,
              child: Material(
                color: Colors.white,
                elevation: 3,
                borderRadius: BorderRadius.circular(12),
                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: _searchController,
                  googleAPIKey: "AIzaSyBGv9znbx4hAdCp_6YK0-HO2XVKI4ZXALk",
                  inputDecoration: const InputDecoration(
                    hintText: "Search location...",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(12),
                  ),
                  debounceTime: 400,
                  isLatLngRequired: true,
                  // getPlaceDetailWithLatLng: (Prediction prediction) {
                  //   if (prediction.lat != null && prediction.lng != null) {
                  //     _updatePosition(LatLng(double.parse(prediction.lat!),
                  //         double.parse(prediction.lng!)));
                  //   }
                  // },
                  // itemClick: (Prediction prediction) {
                  //   _searchController.text = prediction.description ?? "";
                  //   _searchController.selection = TextSelection.fromPosition(
                  //     TextPosition(offset: _searchController.text.length),
                  //   );
                  // },
                  getPlaceDetailWithLatLng: (Prediction prediction) async {
                    if (prediction.lat != null && prediction.lng != null) {
                      _isFromSearch = true;
                      setState(() {
                        _address = prediction.description ?? ""; // 🧠 Human readable address
                      });
                      _updatePosition(LatLng(
                        double.parse(prediction.lat!),
                        double.parse(prediction.lng!),
                      ));
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

            /// 🧭 CURRENT LOCATION BUTTON
            Positioned(
              bottom: 320,
              right: 15,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.white,
                onPressed: _checkAndGetLocation,
                child: const Icon(Icons.my_location, color: Colors.red),
              ),
            ),

            /// 🧾 BOTTOM SHEET WITH FORM
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
                      Text(
                        "Selected Location:",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        _address,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      _buildTextField("House/Flat Number*",
                          controller: houseController),
                      const SizedBox(height: 12),
                      _buildTextField("Receiver Name, Phone",
                          controller: nameController),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ChoiceChip(
                            label: Text(
                              "Home",
                              style: TextStyle(
                                color: isHomeSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            selected: isHomeSelected,
                            selectedColor: HexColor("#004271"),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.grey.shade400),
                            ),
                            checkmarkColor: Colors.white,
                            onSelected: (val) {
                              setState(() => isHomeSelected = true);
                            },
                          ),
                          const SizedBox(width: 12),
                          ChoiceChip(
                            label: Text(
                              "Other",
                              style: TextStyle(
                                color: !isHomeSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            selected: !isHomeSelected,
                            selectedColor: HexColor("#004271"),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.grey.shade400),
                            ),
                            checkmarkColor: Colors.white,
                            onSelected: (val) {
                              setState(() => isHomeSelected = false);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: addressState is AsyncLoading
                              ? null
                              : _saveAddress,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor("#004271"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 0,
                          ),
                          child: addressState is AsyncLoading
                              ? const CircularProgressIndicator(
                              color: Colors.white)
                              : const Text(
                            "Save Address",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
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

  Widget _buildTextField(String label,
      {TextEditingController? controller, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}