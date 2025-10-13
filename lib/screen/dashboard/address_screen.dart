import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/screen/dashboard/payment_screen.dart';
import 'package:quick_home/util/custom_app_bar.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  bool isHomeSelected = true;
  // GoogleMapController? mapController;

  // final LatLng _center = const LatLng(20.011, 73.790);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: CustomAppBar(title: "Address"),
      body: Column(
        children: [

      
      
          // // Map section (untouched)
          // SizedBox(
          //   height: 250,
          //   child: GoogleMap(
          //     onMapCreated: _onMapCreated,
          //     initialCameraPosition: CameraPosition(
          //       target: _center,
          //       zoom: 17.0,
          //     ),
          //     myLocationEnabled: true,
          //     myLocationButtonEnabled: false,
          //     zoomControlsEnabled: false,
          //     liteModeEnabled: false,
          //     mapToolbarEnabled: false,
          //   ),
          // ),
          SizedBox(
            height: 250,
           
          ),
      
          // Address + Form (scrollable)
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address + Change button in same row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(
                              "Mumbai Naka",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kprimary
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Mumbai Naka, Madhav Nagar, Tidke Colony, Nashik, Maharashtra 422002, India",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Change"),
                      ),
                    ],
                  ),
      
                  const Divider(),
      
                  // Form fields
                  _buildTextField("House/Flat Number*"),
                  const SizedBox(height: 12),
                  _buildTextField("Landmark (Optional)"),
                  const SizedBox(height: 12),
                  _buildTextField("Name"),
                  const SizedBox(height: 16),
      
                  // Save As buttons
                  Row(
                    children: [
                      ChoiceChip(
                        label: const Text("Home"),
                        selected: isHomeSelected,
                        onSelected: (val) {
                          setState(() => isHomeSelected = val);
                        },
                      ),
                      const SizedBox(width: 12),
                      ChoiceChip(
                        label: const Text("Other"),
                        selected: !isHomeSelected,
                        onSelected: (val) {
                          setState(() => isHomeSelected = !val);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      
          // Bottom Button
          SafeArea(
            child: Center(
              child: Container(
                width: 350, // fixed width
                height: 44, // fixed height
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: ElevatedButton(
                  onPressed: () {
                    _showSlotSelector(context);
                  },
      
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors.grey.shade300,
                    // foregroundColor: Colors.black54,
                    backgroundColor: HexColor("#3A3A3A"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // radius 10px
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable text field
  Widget _buildTextField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
    );
  }
}

void _showSlotSelector(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    isScrollControlled: true,
    builder: (context) {
      int selectedTime = 1; // index for selected time button
      int selectedDate = 0; // index for selected date button

      List<String> times = [
        "03:30 PM",
        "04:30 PM",
        "05:00 PM",
        "05:30 PM",
        "06:30 PM",
        "07:00 PM",
      ];

      List<String> dates = ["Fri, 26", "Sat, 27", "Sun, 28"];

      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your Qwik Slot - Choose Date & Time",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF353535),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Date selection with custom layout
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(dates.length, (i) {
                    bool isSelected = selectedDate == i;
                    return GestureDetector(
                      onTap: () => setState(() => selectedDate = i),
                      child: Container(
                        width: 108, // fixed width
                        height: 46, // fixed height
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? Color(0xFFD9D9D9) : Colors.white,
                          borderRadius: BorderRadius.circular(
                            5,
                          ), // border-radius 5
                          border: Border.all(
                            color: HexColor("#B4B4B4"), // #353535
                            width: 1,
                          ),
                        ),
                        child: Text(
                          dates[i],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                SizedBox(height: 24),

                // Time selection (can also customize similar to dates)
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(times.length, (i) {
                    bool isSelected = selectedTime == i;
                    return ChoiceChip(
                      label: Text(times[i]),
                      selected: isSelected,
                      onSelected: (val) {
                        setState(() => selectedTime = i);
                      },
                      selectedColor: Color(0xFFD9D9D9),
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Color(0xFF353535), width: 1),
                      ),
                    );
                  }),
                ),

                SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Proceed to Payment",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    },
  );
}
