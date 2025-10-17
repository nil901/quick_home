import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quick_home/screen/dashboard/main_home_screen.dart';
import 'package:quick_home/screen/dashboard/maps.dart';

class OtpVerify extends StatefulWidget {
  final String otp; // received OTP from backend

  const OtpVerify({super.key, required this.otp});

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  List<TextEditingController> otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  bool isResendEnabled = false;
  int remainingSeconds = 30;
  Timer? _timer;
  bool isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  // 🔹 Start countdown for resend
  void _startResendTimer() {
    setState(() {
      isResendEnabled = false;
      remainingSeconds = 30;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 1) {
        setState(() => remainingSeconds--);
      } else {
        timer.cancel();
        setState(() => isResendEnabled = true);
      }
    });
  }

  // 🔹 Validate OTP
  void _checkOtpCompleted() {
    if (otpControllers.every((c) => c.text.isNotEmpty)) {
      String enteredOtp = otpControllers.map((c) => c.text).join();
      print("Entered OTP: $enteredOtp");

      if (enteredOtp == widget.otp) {
        setState(() => isVerifying = true);

        Future.delayed(const Duration(seconds: 1), () {
          setState(() => isVerifying = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("✅ OTP verified successfully!"),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DeliveryLocationPage()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("❌ Invalid OTP, please try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // 🔹 Handle resend OTP
  void _resendOtp() {
    if (isResendEnabled) {
      // TODO: API call for resend OTP here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("🔄 New OTP sent successfully!"),
          backgroundColor: Colors.blueAccent,
        ),
      );
      _startResendTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F6FA),
      body: SafeArea(
        child: Center(
          child:
              isVerifying
                  ? const CircularProgressIndicator(color: Color(0xFF004271))
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Verify your phone number',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Enter your OTP code here',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // 🔹 OTP Fields
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

                      // 🔹 Resend OTP button with timer
                      TextButton(
                        onPressed: isResendEnabled ? _resendOtp : null,
                        child: Text(
                          isResendEnabled
                              ? "RESEND NEW CODE"
                              : "Resend in ${remainingSeconds}s",
                          style: TextStyle(
                            color:
                                isResendEnabled
                                    ? Colors.blue[700]
                                    : Colors.grey,
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
  const SuccessScreen({super.key});

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
