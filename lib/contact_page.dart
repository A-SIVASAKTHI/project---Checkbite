import 'package:flutter/material.dart';
import 'background_wrapper.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Contact Us'),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Contact Support',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  '📧 Email: support@checkbiteapp.com',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                SizedBox(height: 15),

                Text(
                  '📞 Phone: +91 000000 0000',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                SizedBox(height: 15),

                Text(
                  '🌐 Website: www.Checkbiteapp.com',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
