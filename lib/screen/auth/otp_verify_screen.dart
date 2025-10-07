import 'package:flutter/material.dart';
import 'package:quick_home/screen/dashboard/main_home_screen.dart';
import 'package:quick_home/screen/dashboard/selected_address_screen.dart';
import 'package:quick_home/screen/location_screen.dart';

class OtpVerify extends StatefulWidget {
  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _checkOtpCompleted() {
    if (otpControllers.every((controller) => controller.text.isNotEmpty)) {
      String otp = otpControllers.map((c) => c.text).join();
      print("Entered OTP: $otp");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DeliveryLocationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F6FA),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Verify your phone Number',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter your OTP code here',
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              ),
              const SizedBox(height: 40),

              // OTP Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8FAFF),
                      borderRadius: BorderRadius.circular(12),
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
                    child: Center(
                      child: TextField(
                        controller: otpControllers[index],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: const TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.length == 1 && index < 3) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }

                          // ✅ Check OTP after each input
                          _checkOtpCompleted();
                        },
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 35),
              Text(
                "Didn't receive any code?",
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // TODO: Resend OTP logic
                },
                child: Text(
                  "RESEND NEW CODE",
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ Example next screen
class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "OTP Verified Successfully 🎉",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
