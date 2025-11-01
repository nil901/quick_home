import 'package:flutter/material.dart';

class NoDataFoundScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const NoDataFoundScreen({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 164,
                width: 180,
                child: Image.asset('assets/images/no_data_found.png'),
              ),
              const SizedBox(height: 40),
              const Text(
                "No Data found!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "No records to display right now.",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: onRetry, // ✅ Call the passed callback
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF173F67),
                  minimumSize: const Size(170, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "TRY AGAIN",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 1.0,
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
