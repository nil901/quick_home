import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/screen/auth/splash_screen.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: HexColor('#E4F9FF'),
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = HexColor('#E4F9FF'); // Theme color

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: themeColor,
        scaffoldBackgroundColor: themeColor,
        textTheme: GoogleFonts.robotoTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: themeColor,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
