import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/Logic/API/api_provider.dart';
import 'package:quick_home/screen/auth/otp_verify_screen.dart';
import 'package:quick_home/screen/auth/sign_up_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = TextEditingController();
    final authState = ref.watch(authProvider);

    void _showSnackBar(String msg) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }

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
                _buildTextField(
                  phoneController,
                  'Phone Number*',
                  Icons.phone,
                  keyboardType: TextInputType.number,
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
                        BoxShadow(color: Color(0x1A000000), offset: Offset(0, 4), blurRadius: 4),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: authState.isLoading
                          ? null
                          : () async {
                              String phone = phoneController.text.trim();
                              if (phone.isEmpty || phone.length != 10) {
                                _showSnackBar('Enter valid 10-digit number');
                                return;
                              }
                              await ref.read(authProvider.notifier).sendOtp(phone);

                              final updatedState = ref.read(authProvider);
                              if (updatedState.otpSent) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtpVerifyScreen(phone: phone),
                                  ),
                                );
                              } else if (updatedState.errorMessage != null) {
                                _showSnackBar(updatedState.errorMessage!);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: authState.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Send OTP", style: TextStyle(fontSize: 16, color: Colors.white)),
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
                              color: Color(0xff004c8c), fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignupScreen()),
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
          color: const Color(0xFFE8FAFF),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0x8F004271), width: 0.25),
          boxShadow: const [
            BoxShadow(color: Color(0x1A000000), offset: Offset(0, 4), blurRadius: 4),
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black54),
            hintText: hint,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ),
    );
  }
}
