import 'package:flutter/material.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/screen/dashboard/main_home_screen.dart';
import 'package:quick_home/util/custom_app_bar.dart';

class PaymentSummaryScreen extends StatelessWidget {
  const PaymentSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Payment"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "Payment Summary",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: kprimary,
              ),
            ),
          ),
          SizedBox(height: 16),
          // Payment Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                _summaryRow("Home Cleaning", "AED 1,475"),
                SizedBox(height: 8),
                _summaryRow("Home Salon", "AED 1,580"),
                SizedBox(height: 8),
                _summaryRow("Platform fees", "AED 20"),
              ],
            ),
          ),
          SizedBox(height: 16),
          Divider(thickness: 1.1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
            child: _summaryRow("Total Amount", "AED", isBold: true),
          ),
          Spacer(),
          // Done Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
            child: SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainHomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kprimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text("Done", style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String left, String right, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
        Text(
          right,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
