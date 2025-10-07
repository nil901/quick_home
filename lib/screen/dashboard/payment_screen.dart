import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../util/custom_app_bar.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#FFFFFF'),
    appBar: CustomAppBar(title: 'Your Payment'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: HexColor('#EAEAEA'), width: 1
              ),),
              child: Row(
                children: [
                Image.asset('assets/images/home.png', width: 16, height: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Home - Tidake colony, Durvankur Lawns, Nashik',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Icon(Icons.edit_outlined, color: Colors.black),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Date & Time
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: HexColor('#EAEAEA'), width: 1
              ),),
              child: Row(
                children:  [
                  Image.asset('assets/images/timeIcon.png', width: 18, height: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tue, Oct 07 - 4:30 PM',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Icon(Icons.edit_outlined, color: Colors.black),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Service Card
            Container(
              width: double.infinity,
              height: 124,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: HexColor('#E2E2E2'),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🟦 Image Container with border
                  Container(
                    width: 80,
                    height: 95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: HexColor('#B5B5B5'),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/cartIm3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // 🟩 Text + Delete layout
                  Expanded(
                    child: Stack(
                      children: [
                        // Content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Home Deep Cleaning',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: HexColor('#353535'),
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Comprehensive cleaning for a spotless home.',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            Divider(thickness: 1, color: Color(0xFFA1A1A1)),
                            SizedBox(height: 12),
                            Text(
                              'AED 2499',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: HexColor('#353535'),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        // 🟥 Delete icon bottom-right
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/images/delete.png', // 👈 replace with your asset path
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Coupons
            Container(
              width: 350,
              height: 49,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: HexColor('#FCFCFC'), // ✅ Background color
                borderRadius: BorderRadius.circular(10), // ✅ Rounded corners
                border: Border.all(
                  color: HexColor('#EAEAEA'), // ✅ Border color
                  width: 0.25,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // ✅ 0x0000000D equivalent
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.local_offer_outlined, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        'Coupons',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'All Coupons >',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: HexColor('#E4F9FF'),
                borderRadius: BorderRadius.circular(10), // optional for rounded look
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Item total'),
                      Text('AED 2,499'),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Taxes and fee'),
                      Text('AED 50'),
                    ],
                  ),
                  Divider(height: 25, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total amount',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'AED 2,549',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Divider(height: 25, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Amount to pay'),
                      Text(
                        'AED 2,549',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Cancellation Policy
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: HexColor('#FCFCFC'),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: HexColor('#D5D5D5'), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Cancellation policy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'View More',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Book Service Button
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor('#004271'), // ✅ Updated background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // ✅ Updated radius
                  ),
                  elevation: 0, // Flat design (optional)
                ),
                onPressed: () {},
                child: const Text(
                  'Book Service',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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
