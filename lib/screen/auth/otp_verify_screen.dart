import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_home/Logic/API/api_provider.dart';
import '../dashboard/main_home_screen.dart';

class OtpVerifyScreen extends ConsumerWidget {
  final String phone;
  const OtpVerifyScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpController = TextEditingController();
    final authState = ref.watch(authProvider);

    void _showSnackBar(String msg) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text("OTP sent to $phone", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Enter OTP"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: authState.isLoading
                  ? null
                  : () async {
                      String otp = otpController.text.trim();
                      if (otp.isEmpty) {
                        _showSnackBar("Please enter OTP");
                        return;
                      }

                      await ref.read(authProvider.notifier).verifyOtp(phone, otp);
                      final updatedState = ref.read(authProvider);

                      if (updatedState.isVerified) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => MainHomeScreen()),
                        );
                      } else if (updatedState.errorMessage != null) {
                        _showSnackBar(updatedState.errorMessage!);
                      }
                    },
              child: authState.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
