import 'package:flutter/material.dart';
import 'background_wrapper.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent, // ✅ allow background to show
        appBar: AppBar(
          title: const Text('Contact Us'),
          backgroundColor: Colors.teal, // optional for contrast
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              Text(
                'Email: checkbite@app.com',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Phone: +91 98765 43210',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
