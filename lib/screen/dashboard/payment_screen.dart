import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../util/custom_app_bar.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: HexColor('#FFFFFF'),
      appBar: CustomAppBar(title: 'Your Payment'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Step Progress Bar (CART - ADDRESS - PAYMENT)
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStepText('CART', false, width),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness:
                          1, // dashPattern is not a valid property for Divider
                      indent: width * 0.02,
                      endIndent: width * 0.02,
                    ),
                  ),
                  _buildStepText('ADDRESS', false, width),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade400,
                      thickness:
                          1, // dashPattern is not a valid property for Divider
                      indent: width * 0.02,
                      endIndent: width * 0.02,
                    ),
                  ),
                  _buildStepText('PAYMENT', true, width),
                ],
              ),
            ),

            // 🏠 Address Section
            Container(
              padding: EdgeInsets.all(width * 0.03),
              decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.circular(width * 0.03),
                border: Border.all(color: HexColor('#EAEAEA'), width: 1),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/home.png',
                    width: width * 0.045,
                    height: height * 0.022,
                  ),
                  SizedBox(width: width * 0.025),
                  Expanded(
                    child: Text(
                      'Home - Tidake colony, Durvankur Lawns, Nashik',
                      style: TextStyle(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.black,
                    size: width * 0.05,
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.015),

            // 🕒 Date & Time Section
            Container(
              padding: EdgeInsets.all(width * 0.03),
              decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.circular(width * 0.03),
                border: Border.all(color: HexColor('#EAEAEA'), width: 1),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/timeIcon.png',
                    width: width * 0.045,
                    height: height * 0.022,
                  ),
                  SizedBox(width: width * 0.025),
                  Expanded(
                    child: Text(
                      'Tue, Oct 07 - 4:30 PM',
                      style: TextStyle(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: Colors.black,
                    size: width * 0.05,
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),

            // 🧹 Service Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.03),
              decoration: BoxDecoration(
                color: HexColor('#FFFFFF'),
                borderRadius: BorderRadius.circular(width * 0.04),
                border: Border.all(color: HexColor('#E2E2E2'), width: 1),
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🟦 Image Container
                    Container(
                      width: width * 0.22,
                      height: height * 0.115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.05),
                        border: Border.all(
                          color: HexColor('#B5B5B5'),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(width * 0.05),
                        child: Image.asset(
                          'assets/images/cartIm3.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.03),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: height * 0.005),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Home Deep Cleaning',
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w600,
                                    color: HexColor('#353535'),
                                  ),
                                ),
                                SizedBox(height: height * 0.006),
                                Text(
                                  'Comprehensive cleaning for a spotless home.',
                                  style: TextStyle(
                                    fontSize: width * 0.03,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: height * 0.010),
                                Divider(
                                  thickness: 1,
                                  color: const Color(0xFFA1A1A1),
                                ),
                                SizedBox(height: height * 0.010),
                                Text(
                                  'AED 2499',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#353535'),
                                    fontSize: width * 0.035,
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset(
                                'assets/images/delete.png',
                                width: width * 0.055,
                                height: width * 0.055,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),

            // 🎟️ Coupons
            Container(
              width: double.infinity,
              height: height * 0.06,
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              decoration: BoxDecoration(
                color: HexColor('#FCFCFC'),
                borderRadius: BorderRadius.circular(width * 0.03),
                border: Border.all(color: HexColor('#EAEAEA'), width: 0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.local_offer_outlined,
                        color: Colors.black,
                        size: width * 0.05,
                      ),
                      SizedBox(width: width * 0.02),
                      Text(
                        'Coupons',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.035,
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
                      fontSize: width * 0.033,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.025),

            // 💰 Price Details
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                color: HexColor('#FFF'),
                borderRadius: BorderRadius.circular(width * 0.03),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.blue.shade50,
                    child: Text(
                      'Price Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.04,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Item total',
                        style: TextStyle(fontSize: width * 0.035),
                      ),
                      Text(
                        'AED 2,499',
                        style: TextStyle(fontSize: width * 0.035),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Taxes and fee',
                        style: TextStyle(fontSize: width * 0.035),
                      ),
                      Text('AED 50', style: TextStyle(fontSize: width * 0.035)),
                    ],
                  ),
                  Divider(height: height * 0.03, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total amount',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.036,
                        ),
                      ),
                      Text(
                        'AED 2,549',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.036,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: height * 0.03, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount to pay',
                        style: TextStyle(fontSize: width * 0.035),
                      ),
                      Text(
                        'AED 2,549',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: width * 0.035,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.025),

            // ❌ Cancellation Policy
            Container(
              padding: EdgeInsets.all(width * 0.03),
              decoration: BoxDecoration(
                color: HexColor('#FCFCFC'),
                borderRadius: BorderRadius.circular(width * 0.03),
                border: Border.all(color: HexColor('#D5D5D5'), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cancellation policy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.037,
                    ),
                  ),
                  SizedBox(height: height * 0.008),
                  Text(
                    'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text.',
                    style: TextStyle(
                      fontSize: width * 0.03,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'View More',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.033,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.03),

            // 🔵 Book Service Button
            SizedBox(
              width: double.infinity,
              height: height * 0.055,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor('#004271'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.04),
                  ),
                  elevation: 0,
                ),
                onPressed: () {},
                child: Text(
                  'Book Service',
                  style: TextStyle(
                    fontSize: width * 0.04,
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

  Widget _buildStepText(String text, bool isActive, double width) {
    return Text(
      text,
      style: TextStyle(
        fontSize: width * 0.035,
        fontWeight: FontWeight.w700,
        color: isActive ? Colors.blue.shade800 : Colors.grey.shade600,
      ),
    );
  }
}
