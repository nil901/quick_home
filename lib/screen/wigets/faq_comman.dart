import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FaqComman extends StatefulWidget {
  const FaqComman({super.key});

  @override
  State<FaqComman> createState() => _FaqCommanState();
}

class _FaqCommanState extends State<FaqComman> {
  final faqs = [
    "Why Choose Quick Fix?",
    "Do I need an account to book?",
    "Can I choose the professional?",
    "How soon can I get the service?",
    "Can I choose the professional?",
    "How soon can I get the service?",
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: HexColor("#F4F2F2"),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 0,
              ),
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              collapsedIconColor: Colors.black,
              iconColor: Colors.black,
              minTileHeight: 40,
              title: Text(
                faqs[index],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Text(
                  "This is a sample answer for '${faqs[index]}'",
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
