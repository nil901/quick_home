import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/screen/auth/otp_verify_screen.dart';
import 'package:quick_home/screen/auth/sign_up_screen.dart';

import '../dashboard/main_home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  // void login() {
  //   String phone = phoneController.text.trim();
  //
  //   if (phone.isEmpty) {
  //     _showSnackBar('Please enter mobile number');
  //   } else if (phone.length != 10) {
  //     _showSnackBar('Mobile number must be 10 digits');
  //   } else {
  //     _showSnackBar('Login Successful!');
  //
  //     // ✅ Navigate to Home Screen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => ()),
  //     );
  //   }
  // }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: Duration(seconds: 2)),
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
                SizedBox(height: 220),
                Text(
                  "Log In",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  "Book, track, and manage trusted home services with ease",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: _buildTextField(
                    phoneController,
                    'Phone Number*',
                    Icons.phone,
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Container(
                    width: 270,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Color(0xFF004271), // background
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color(0x8F004271),
                        width: 0.25,
                      ), // border
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1A000000), // #0000001A
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        String phone = phoneController.text.trim();

                        if (phone.isEmpty) {
                          _showSnackBar('Please enter mobile number');
                        } else if (phone.length != 10) {
                          _showSnackBar('Mobile number must be 10 digits');
                        } else {
                          _showSnackBar('Login Successful!');

                          // ✅ Navigate to Home Screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpVerify(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.transparent, // keep container color
                        shadowColor:
                            Colors.transparent, // remove default shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Send OTP",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don’t have an account?",
                      style: TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          text: "Sign up here",
                          style: TextStyle(
                            color: Color(0xff004c8c),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to LoginScreen
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
      padding: const EdgeInsets.only(left: 52, right: 52, top: 0, bottom: 0),
      child: Container(
        // width: 270, // width match
        height: 46, // height match
        margin: EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
          color: Color(0xFFE8FAFF), // background
          borderRadius: BorderRadius.circular(15), // border-radius
          border: Border.all(color: Color(0x8F004271), width: 0.25), // border
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000), // shadow
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
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ),
    );
  }
}
