import 'package:flutter/material.dart';

class PaymentSummaryScreen extends StatelessWidget {
  const PaymentSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top AppBar like Row
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 16, 14, 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, size: 24)),
                  SizedBox(width: 8),
                  Text(
                    "Your Cart",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Payment Summary",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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
              child: _summaryRow(
                "Total Amount",
                "AED",
                isBold: true,
              ),
            ),
            Spacer(),
            // Done Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
              child: SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
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