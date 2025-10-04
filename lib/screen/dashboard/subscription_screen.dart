import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/screen/wigets/faq_comman.dart';
import 'package:quick_home/util/size.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      {
        "title": "One-Time Quick Fix",
        "desc": "Single service, anytime you need.",
        "price": "₹ 3999",
      },
      {
        "title": "QwikCare Weekly",
        "desc": "Short-term plan with weekly savings.",
        "price": "AED 11,999",
      },
      {
        "title": "QwikCare Monthly",
        "desc": "Best choice for regular users.",
        "price": "AED 24,999",
      },
      {
        "title": "QwikCare Annual",
        "desc": "Maximum value for the whole year.",
        "price": "AED 90,000",
      },
    ];

   

    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.black),
        titleSpacing: 0,
        title: const Text("Subscription",
            style: TextStyle(color: Colors.black, fontSize: 18)),
        backgroundColor: kwhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Subscription Plans Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(plan["title"]!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                      h10,
                      Text(plan["desc"]!,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black54)),
                     // const Spacer(),
                     h10,
                      Text(plan["price"]!,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            /// CTA Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  "Get One-Time Now",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              "Book instantly and get a professional at your doorstep.",
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),

            const SizedBox(height: 20),

            /// Quick FAQs
            const Text("Quick FAQs",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),

         FaqComman()

          ],
        ),
      ),
    );
  }
}




