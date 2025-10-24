import 'package:flutter/material.dart';
import 'background_wrapper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent, // ✅ transparent so image shows
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'CHECKBITE',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Image.asset('assets/logo.png', height: 150),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text('Start'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
