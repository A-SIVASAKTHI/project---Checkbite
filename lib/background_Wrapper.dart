import 'package:flutter/material.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;

  const BackgroundWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,          // ✅ fill entire screen
        ),
      ),
      child: child,                   // ✅ directly place your page here
    );
  }
}
