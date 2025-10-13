import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int saveAs = 0; // 0=Home, 1=Office, 2=Other

  Widget _buildTextField({
    required String label,
    bool isBig = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      keyboardType: keyboardType,
      maxLines: isBig ? 3 : 1,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: isBig ? 18 : 10,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Colors
    final kPrimary = HexColor("#004271");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.88,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tabs Row
                Padding(
                  padding: EdgeInsets.only(top: 12, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _tabTitle("CART", false),
                      SizedBox(width: 15),
                      Text('--------------'),
                      SizedBox(width: 15),
                      _tabTitle("ADDRESS", true, color: Color(0xff004271)),
                      SizedBox(width: 15),
                      Text('--------------'),
                      SizedBox(width: 15),
                      _tabTitle("PAYMENT", false),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                // Live Location Row
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_sharp, color: Colors.black),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "Live Location",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        height: 36,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Change",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  child: Text(
                    "Tidke colony, Durwankur Lawns, Nashik  ⌄",
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                SizedBox(height: 10),
                // Add Detailed Address Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Add Detailed Address",
                    style: TextStyle(
                      fontSize: 14.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Form grid of fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Top 2 fields in a row
                      Row(
                        children: [
                          Expanded(child: _buildTextField(label: "Name*")),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              label: "Phone No*",
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: _buildTextField(label: "Email ID*")),
                          SizedBox(width: 12),
                          Expanded(child: _buildTextField(label: "City*")),
                        ],
                      ),
                      SizedBox(height: 12),
                      // Big address textbox
                      _buildTextField(
                        label: "Address* (House No, Building, Street, area)",
                        isBig: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Row(
                    children: [Text('Save as', style: TextStyle(fontSize: 19))],
                  ),
                ),
                SizedBox(height: 12),
                // Save as options
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _saveAsChip(
                        "Home",
                        saveAs == 0,
                        () => setState(() => saveAs = 0),
                      ),
                      _saveAsChip(
                        "Office",
                        saveAs == 1,
                        () => setState(() => saveAs = 1),
                      ),
                      _saveAsChip(
                        "Other",
                        saveAs == 2,
                        () => setState(() => saveAs = 2),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                // Add slot button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8.0,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        // slot add kare
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff004271),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Add slot",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabTitle(String text, bool isActive, {Color color = Colors.grey}) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            fontSize: 13.8,
            color: color,
            decoration: isActive ? TextDecoration.none : TextDecoration.none,
            decorationThickness: 2,
          ),
        ),
      ],
    );
  }

  Widget _saveAsChip(String label, bool selected, VoidCallback onTap) {
    final Color blueBorder = HexColor("#3993EF");
    final Color greyBorder = Colors.grey.shade300;
    final Color textColor = selected ? Color(0xff004271) : Colors.grey;
    final Color bgColor = selected ? HexColor("#E6F0FA") : Colors.white;
    final Color borderColor = selected ? Color(0xff004271) : greyBorder;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor, width: 1.7),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
<<<<<<< HEAD
=======

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
>>>>>>> nilesh_branch
