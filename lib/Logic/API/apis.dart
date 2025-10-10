import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/login_model.dart';

class ApiService {
  static const String baseUrl = "http://admin.qwikhom.ae/api/";

  /// 🔹 Send OTP
  static Future<LoginModel?> sendOtp(String phone) async {
    final url = Uri.parse("${baseUrl}login");
    try {
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
        },
        body: {
          "phone": phone,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LoginModel.fromJson(data);
      } else {
        print("❌ OTP Send Failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("⚠️ Error sending OTP: $e");
      return null;
    }
  }

  /// 🔹 Verify OTP
  static Future<LoginModel?> verifyOtp(String phone, String otp) async {
    final url = Uri.parse("${baseUrl}verify-otp");
    try {
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
        },
        body: {
          "phone": phone,
          "otp": otp,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return LoginModel.fromJson(data);
      } else {
        print("❌ OTP Verify Failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("⚠️ Error verifying OTP: $e");
      return null;
    }
  }
}
