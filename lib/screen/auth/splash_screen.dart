import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quick_home/screen/auth/login_screen.dart';


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

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
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
      backgroundColor: HexColor('#E4F9FF'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/splash2.png", width: 200, height: 200),
            SizedBox(height: 20),
            ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOutBack,
              ),
              child: Image.asset("assets/images/logo.png", height: 50),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _controller.value,
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