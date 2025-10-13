import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/api_services/urls.dart';
import 'package:quick_home/screen/auth/login_screen.dart';
import '../dashboard/main_home_screen.dart';
import '../../util/toast_msg.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  final Utils utils = Utils(); // <-- Utils instance

  Future<void> createAccount() async {
    String name = nameController.text.trim();
    String mobile = mobileController.text.trim();
    String email = emailController.text.trim();

    // ✅ Validations with toast
    if (name.isEmpty) {
      utils.showTost('Please enter full name');
      return;
    } else if (mobile.isEmpty) {
      utils.showTost('Please enter mobile number');
      return;
    } else if (mobile.length != 10) {
      utils.showTost('Mobile number must be 10 digits');
      return;
    } else if (email.isEmpty) {
      utils.showTost('Please enter email address');
      return;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email)) {
      utils.showTost('Please enter a valid email address');
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await ApiService.postRequest(
        signupUrl,
        {
          "name": name,
          "email": email,
          "phone": mobile,
        },
      );
      if (response.data["success"] == true) {
        final message = response.data["message"] ?? "Signup successful!";
        final otp = response.data["otp"] ?? "";
        utils.showTost("$message\nOTP: $otp");

        // ✅ Navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainHomeScreen()),
        );
      } else {
        final message = response.data["message"] ?? "the user is already exist!";
        utils.showTost(message);
      }
    } catch (e) {
      if (e is ApiException) {
        utils.showTost(e.message);
      } else {
        utils.showTost("Signup failed: $e");
      }
    }
    finally {
      setState(() => isLoading = false);
    }
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
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Sign up in just a few steps to explore a wide range of reliable services at your doorstep.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
                const SizedBox(height: 40),
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
                      const SizedBox(height: 16),
                      _buildTextField(
                        mobileController,
                        'Mobile Number*',
                        'assets/images/phoneicon.png',
                        keyboardType: TextInputType.number,
                        imageWidth: 18,
                        imageHeight: 18,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        emailController,
                        'Email Address*',
                        'assets/images/mailicon.png',
                        keyboardType: TextInputType.emailAddress,
                        imageWidth: 20,
                        imageHeight: 16,
                      ),
                    ],
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
                      border: Border.all(color: const Color(0x8F004271), width: 0.25),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: isLoading ? null : createAccount,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        "Create Account",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          text: "Log In",
                          style: const TextStyle(
                              color: Color(0xff004c8c), fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
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
        double imageWidth = 24,
        double imageHeight = 24,
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
          fillColor: const Color(0xFFE8FAFF),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0x8F004271), width: 0.25),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0x8F004271), width: 0.25),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFF004271), width: 0.25),
          ),
        ),
      ),
    );
  }
}
