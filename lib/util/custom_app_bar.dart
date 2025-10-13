import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: HexColor('#E4F9FF'), // Light blue
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20), // Rounded bottom edges
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (showBackButton)
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ),
            if (showBackButton)
              SizedBox(width: 48), // To balance the back button space
          ],
        ),
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(100); // Layout ke according
}
