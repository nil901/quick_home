import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/screen/dashboard/address_screen.dart';
import 'package:quick_home/screen/dashboard/payment_screen.dart';
import 'package:quick_home/util/custom_app_bar.dart';

class SelectedMyAddress extends StatelessWidget {
  final List<Map<String, String>> addresses = [
    {
      'name': 'Samiksha Raka',
      'address':
          '12, 6th floor, Asha building, Tidake colony,\nnear Durvankar lawns, Nashik, Maharashtra - 422009',
      'mobile': '8356744554',
      'isDefault': 'true',
    },
    {
      'name': 'Samiksha Raka',
      'address':
          'Flat 5C, Green Park Residency, College Road,\nNashik, Maharashtra - 422006',
      'mobile': '8356744554',
      'isDefault': 'false',
    },
    {
      'name': 'Samiksha Raka',
      'address':
          'House No. 21, Shanti Nagar, Indiranagar,\nNashik, Maharashtra - 422009',
      'mobile': '8356744554',
      'isDefault': 'false',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'My Address'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text(
                "Select Delivery Address",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                "DEFAULT ADDRESS",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              _addressCard(addresses[0], isSelected: true),
              SizedBox(height: 20),
              Text(
                "OTHER ADDRESS",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              _addressCard(addresses[1]),
              _addressCard(addresses[2]),
              SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddressScreen()),
                  );
                },
                icon: Icon(Icons.add, color: Color(0xFF004271)),
                label: Text(
                  'Add New Address',
                  style: TextStyle(color: Color(0xFF004271)),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFF004271)),
                ),
              ),
              SafeArea(
                child: Center(
                  child: Container(
                    width: 350,
                    height: 44,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: ElevatedButton(
                      onPressed: () {
                        _showSlotSelector(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kprimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Save and proceed to slots",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addressCard(Map<String, String> addr, {bool isSelected = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Radio(
            value: true,
            groupValue: isSelected,
            onChanged: (_) {},
            activeColor: Color(0xFF004271),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  addr['name']!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  addr['address']!,
                  style: TextStyle(color: Colors.black87, fontSize: 13),
                ),
                SizedBox(height: 6),
                Text(
                  'Mobile: ${addr['mobile']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                if (isSelected)
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: Text('REMOVE', style: TextStyle(fontSize: 12)),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 0,
                          ),
                          minimumSize: Size(10, 32),
                        ),
                      ),
                      SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text('EDIT', style: TextStyle(fontSize: 12)),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 0,
                          ),
                          minimumSize: Size(10, 32),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSlotSelector(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: kscoundPrimaryColor,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (context) {
        int selectedTime = 1;
        int selectedDate = 0;
        int selectedExpert = -1;

        List<String> times = [
          "03:30 PM",
          "04:30 PM",
          "05:00 PM",
          "05:30 PM",
          "06:30 PM",
          "07:00 PM",
        ];

        List<String> dates = [
          "Mon, 22",
          "Tue, 23",
          "Wed, 24",
          "Thu, 25",
          "Fri, 26",
          "Sat, 27",
          "Sun, 28",
        ];

        List<Map<String, String?>> experts = [
          {"name": "Best Match for\nYour Service", "image": null},
          {"name": "Megha", "image": "assets/images/Megha.png"},
        ];

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 3,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Your Qwik Slot - Choose Date & Time",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color(0xFF353535),
                            ),
                          ),
                        ),

                        SizedBox(width: 90),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Icon(Icons.close),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Dates
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          // --- Static "Oct" box first ---
                          Container(
                            width: 60,
                            height: 70,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 17.0),
                                    child: Text(
                                      "Oct",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                // Empty space for alignment (since 'Oct' has no date number)
                                Text(
                                  "",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // --- Rest of the dates as before ---
                          ...List.generate(dates.length, (i) {
                            List<String> parts = dates[i].split(',');
                            String label1 = parts[0].trim();
                            String label2 =
                                parts.length > 1 ? parts[1].trim() : "";
                            bool isSelected = (selectedDate == i);
                            return GestureDetector(
                              onTap: () => setState(() => selectedDate = i),
                              child: Container(
                                width: 60,
                                height: 70,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? Color(0xFF004271)
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      label1,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            isSelected
                                                ? Colors.white
                                                : Colors.grey.shade600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      label2,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            isSelected
                                                ? Colors.white
                                                : Colors.grey.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Selected Time",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF353535),
                      ),
                    ),
                  ),

                  // Times
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(times.length, (i) {
                      bool isSelected = selectedTime == i;
                      return ChoiceChip(
                        label: Text(times[i]),
                        selected: isSelected,
                        onSelected: (val) => setState(() => selectedTime = i),
                        selectedColor: kprimary,
                        backgroundColor: kscoundPrimaryColor,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : kblack,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: kprimary, width: 1),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 32),

                  Padding(
                    padding: const EdgeInsets.only(left: 9.0, bottom: 13.0),
                    child: Text(
                      'Choose your Expert',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF353535),
                      ),
                    ),
                  ),

                  // 🔹 CHANGED: Added horizontal scroll + reduced spacing
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(experts.length, (index) {
                        final expert = experts[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            right: 10,
                          ), // 🔹 CHANGED: small gap
                          child: ExpertCard(
                            name: expert['name']!,
                            imagePath: expert['image'],
                            isSelected: selectedExpert == index,
                            onTap: () => setState(() => selectedExpert = index),
                          ),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentSummaryScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kprimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Proceed to Payment",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

//
// ✅ Reusable Expert Card Widget
//
class ExpertCard extends StatelessWidget {
  final String name;
  final String? imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const ExpertCard({
    super.key,
    required this.name,
    this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected ? Colors.blue.shade900 : Colors.white,
                width: 2,
              ),
              boxShadow: isSelected ? [] : [],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  imagePath != null && imagePath!.isNotEmpty
                      ? Image.asset(imagePath!, fit: BoxFit.cover)
                      : Icon(
                        Icons.person,
                        size: 45,
                        color: Colors.grey.shade500,
                      ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF353535),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
