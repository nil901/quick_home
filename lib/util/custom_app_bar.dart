import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/screen/dashboard/main_home_screen.dart';
import 'package:quick_home/util/enum.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? showBackButton; // 👈 आता हा function आहे, bool नाही
  final BottomTab? targetTab;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton, // 👈 method optional आहे
    this.targetTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: HexColor('#E4F9FF'),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (showBackButton != null) {
                  // 👈 जर custom method दिली असेल तर ती call होईल
                  showBackButton!();
                } else if (targetTab != null) {
                  // 👈 targetTab असेल तर त्या tab वर जा
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MainHomeScreen(initialTab: targetTab!),
                    ),
                    (route) => false,
                  );
                } else {
                  // 👈 default pop
                  Navigator.pop(context);
                }
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
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
