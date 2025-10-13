import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:quick_home/screen/auth/otp_verify_screen.dart';
import 'package:quick_home/screen/auth/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  /// 🔹 Login API Call
  Future<void> login() async {
    String phone = phoneController.text.trim();
    if (phone.isEmpty) {
      _showSnackBar('Please enter mobile number');
      return;
    } else if (phone.length != 10) {
      _showSnackBar('Mobile number must be 10 digits');
      return;
    }

    final url = Uri.parse("http://admin.qwikhom.ae/api/login");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      print("Raw response: ${response.body}"); // ✅ debug

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          // 🔹 Correctly access OTP from API response
          String otp = '';
          if (data.containsKey('otp')) {
            otp = data['otp'].toString();
          } else if (data.containsKey('data') && data['data'] != null) {
            otp = data['data']['otp'].toString();
          }

          print("Received OTP: $otp"); // ✅ debug

          _showSnackBar('OTP Sent Successfully!');

          // Navigate to OTP Verification screen with phone and otp
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerify(phoneNumber: phone, apiOtp: otp),
            ),
          );
        } else {
          _showSnackBar(data['message'] ?? 'Login Failed!');
        }
      } else {
        _showSnackBar('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      _showSnackBar('Error: $e');
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E4F9FF'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 220),
                const Text(
                  "Log In",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Book, track, and manage trusted home services with ease",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: _buildTextField(
                    phoneController,
                    'Phone Number*',
                    Icons.phone,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Container(
                    width: 270,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFF004271),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0x8F004271),
                        width: 0.25,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Send OTP",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don’t have an account? ",
                      style: const TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          text: "Sign up here",
                          style: const TextStyle(
                            color: Color(0xff004c8c),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignupScreen(),
                                    ),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 52, right: 52),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: const Color(0xFFE8FAFF),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0x8F004271), width: 0.25),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black54),
            hintText: hint,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
          ),
        ),
      ),
    );
  }
}
