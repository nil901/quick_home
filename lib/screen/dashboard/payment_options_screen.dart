import 'package:flutter/material.dart';

class PaymentOptionsScreen extends StatelessWidget {
  const PaymentOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Options')),
      body: const Center(child: Text('Payment Options Screen')),
    );
  }
}
