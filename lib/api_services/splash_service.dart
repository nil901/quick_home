import 'package:flutter/material.dart';
import 'package:quick_home/prefs/app_preference.dart';
import 'package:quick_home/prefs/preferences_keys.dart';
import 'package:quick_home/screen/auth/login_screen.dart';
import 'package:quick_home/screen/dashboard/main_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashServices {
  Future<void> checkAuthentication(BuildContext context) async {
   
    final token = AppPreference().getInt(PreferencesKey.userId);

   
    debugPrint('User Token: $token');

   
    await Future.delayed(const Duration(seconds: 2));

    if (token == 0) {
     
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
      );
    } else {
     
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  MainHomeScreen()),
      );
    }
  }
}
