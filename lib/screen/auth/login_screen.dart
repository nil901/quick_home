import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/api_services/api_services.dart';
import 'package:quick_home/screen/auth/otp_verify_screen.dart';
import 'package:quick_home/screen/auth/sign_up_screen.dart';
import '../../util/toast_msg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  final utils = Utils(); // Utils instance

  void _showToast(String msg) {
    utils.showTost(msg);
  }

  Future<void> loginUser() async {
    String phone = phoneController.text.trim();

    if (phone.isEmpty) {
      _showToast('Please enter mobile number');
      return;
    } else if (phone.length != 10) {
      _showToast('Mobile number must be 10 digits');
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await ApiService.postRequest(
        '/login',
        {"phone": phone},
      );

      if (response.data['success'] == true) {
        final otp = response.data['data']['otp'].toString();
        final user = response.data['data']['user'];
        _showToast('OTP sent: $otp');

        print('user data: $user'); // For testing purposes)


        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerify(

            ),
          ),
        );
      } else {
        _showToast(response.data['message'] ?? 'Login failed');
      }
    } catch (e) {
      _showToast(e.toString());
    } finally {
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
                  child: isLoading
                      ? CircularProgressIndicator()
                      : SizedBox(
                    width: 270,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: loginUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF004271),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Send OTP",
                        style:
                        TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don’t have an account? ",
                      style: TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          text: "Sign up here",
                          style: TextStyle(
                            color: Color(0xff004c8c),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
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
      padding: const EdgeInsets.symmetric(horizontal: 52),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Color(0xFFE8FAFF),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0x8F004271), width: 0.25),
          boxShadow: [
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
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ),
    );
  }
}
