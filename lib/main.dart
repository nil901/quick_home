import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod import करा
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_home/color/colors.dart';
import 'package:quick_home/screen/auth/splash_screen.dart';
import 'package:quick_home/screen/location_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: kwhite,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const ProviderScope(child: MyApp())); // ProviderScope wrapper
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QwickHome',
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
      home: LocationPickerScreen(),
    );
  }
}
