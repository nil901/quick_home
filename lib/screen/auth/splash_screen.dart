import 'package:flutter/material.dart';
import 'package:quick_home/screen/dashboard/main_home_screem.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Progress + Logo animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4), // full splash screen time
    )..forward();

    // On complete go to home
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
         Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainHomeScreen()),
      );
    
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 0.5, curve: Curves.easeOutBack),
              ),
              child: Image.asset(
                "assets/images/logo.png",
                height: 50,
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _controller.value, // smooth progress
                    minHeight: 5,
                    backgroundColor: Colors.grey[300],
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
