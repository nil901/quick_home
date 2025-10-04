import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/screen/auth/login_screen.dart';

import '../dashboard/main_home_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void createAccount() {
    String name = nameController.text.trim();
    String mobile = mobileController.text.trim();
    String email = emailController.text.trim();

    if (name.isEmpty) {
      _showSnackBar('Please enter full name');
    } else if (mobile.isEmpty) {
      _showSnackBar('Please enter mobile number');
    } else if (mobile.length != 10) {
      _showSnackBar('Mobile number must be 10 digits');
    } else if (email.isEmpty) {
      _showSnackBar('Please enter email address');
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(email)) {
      _showSnackBar('Please enter a valid email address');
    } else {
      _showSnackBar('Account Created Successfully!');

      // ✅ Signup successful → Navigate to Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainHomeScreen()),
      );
    }
  }

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
                Text("Create Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                Text(
                  "Sign up in just a few steps to explore a wide range of reliable services at your doorstep.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        nameController,
                        'Enter Full Name*',
                        'assets/images/usericon.png',
                        imageWidth: 18,
                        imageHeight: 21,
                      ),
                      SizedBox(height: 16),
                      _buildTextField(
                        mobileController,
                        'Mobile Number*',
                        'assets/images/phoneicon.png',
                        keyboardType: TextInputType.number,
                        imageWidth: 18,
                        imageHeight: 18,
                      ),
                      SizedBox(height: 16),
                      _buildTextField(
                        emailController,
                        'Email Address*',
                        'assets/images/mailicon.png',
                        keyboardType: TextInputType.emailAddress,
                        imageWidth: 20,
                        imageHeight: 16,
                      ),

                      // _buildTextField(nameController, 'Enter Full Name*', Icons.person),
                    ],
                  ),
                ),
                SizedBox(height: 30),
          
                Center(
                  child: Container(
                    width: 270,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Color(0xFF004271),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0x8F004271), width: 0.25),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1A000000), // #0000001A
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: createAccount,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // important to keep container color
                        shadowColor: Colors.transparent, // disable default shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Create Account",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                )
          ,
                SizedBox(height: 16),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          text: "Log In",
                          style: TextStyle(
                              color: Color(0xff004c8c), fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navigate to LoginScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
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
      String imagePath, {
        TextInputType keyboardType = TextInputType.text,
        double imageWidth = 24,   // default width
        double imageHeight = 24,  // default height
      }) {
    return SizedBox(
      width: 270,
      height: 46,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              imagePath,
              width: imageWidth,
              height: imageHeight,
            ),
          ),
          hintText: hint,
          filled: true,
          fillColor: Color(0xFFE8FAFF),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0x8F004271), width: 0.25),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0x8F004271), width: 0.25),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xFF004271), width: 0.25),
          ),
        ),
      ),
    );
  }


}