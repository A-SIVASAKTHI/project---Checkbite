import 'package:flutter/material.dart';
import 'background_wrapper.dart'; // <-- Import wrapper

class ResultPage extends StatelessWidget {
  final String imageUrl;

  const ResultPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(                // <-- Wrap entire page
      child: Scaffold(
        backgroundColor: Colors
            .transparent,                    // <-- Important for background image
        appBar: AppBar(
          title: const Text('Scan Result'),
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                imageUrl,
                height: 200,
                width: 200,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
              const SizedBox(height: 20),
              const Text(
                'Result: Possibly Diseased',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
