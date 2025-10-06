import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/screen/dashboard/address_screen.dart';
import 'package:quick_home/screen/dashboard/selected_address_screen.dart';
import 'package:quick_home/util/custom_app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "My Cart",),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),

            // First card
            _buildServiceCard(
              imagePath: 'assets/images/cartIm3.png',
              title: 'Home Deep Cleaning',
              description: 'Comprehensive cleaning for a spotless home.',
              price: 'AED 2499',
            ),

            // Second card
            _buildServiceCard(
              imagePath: 'assets/images/cartIm1.png',
              title: 'AC Repair & Servicing',
              description:
                  'Quick and professional AC maintenance at your doorstep.',
              price: 'AED 1499',
            ),

            // Third card
            _buildServiceCard(
              imagePath: 'assets/images/cartIm2.png',
              title: 'Salon for Women',
              description:
                  'At-home beauty and self-care services, customized for you.',
              price: 'AED 1499',
            ),

            const Spacer(),

            // Bottom buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Row(
                children: [
                Expanded(
  child: InkWell(
    onTap: () {
      // TODO: your tap logic here
    },
    borderRadius: BorderRadius.circular(8), 
    child: Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color:kprimary, width: 1), 
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        "Add Services",
        style: TextStyle(
          color:kprimary,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    ),
  ),
),

                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectedMyAddress(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:kprimary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(0, 44),
                      ),
                      child: const Text("Add address & slot"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String imagePath,
    required String title,
    required String description,
    required String price,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Container(
        width: double.infinity,
        height: 125,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE2E2E2), // #E2E2E2
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              // Asset Image
              Container(
                width: 80,
                height: 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E2E2), width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: kprimary

                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // Divider
                    Divider(color: HexColor("#A1A1A1"), thickness: 0.5),
                    const SizedBox(height: 4),
                    // Row for Price, Quantity, Delete
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style:  TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: kprimary
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 63, // fixed width
                              height: 25, // fixed height
                              decoration: BoxDecoration(
                                color: kscoundPrimaryColor,
                                borderRadius: BorderRadius.circular(
                                  5,
                                ), // border-radius 5
                                // border: Border.all(
                                //   color: const Color(0xFF353535), // #353535
                                //   width: 0.5,
                                // ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children:  [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                    ),
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: kprimary,
                                      ),
                                    ),
                                  ),
                                  Text('1', style: TextStyle(fontSize: 16)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                    ),
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: kprimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () {
                                // Delete action
                              },
                              child: Image.asset(
                                'assets/images/delete.png',
                                width: 17,
                                height: 22,
                                color: kprimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
