import 'package:flutter/material.dart';
import 'result_page.dart';
import 'background_wrapper.dart'; // ✅ Import this

class SymptomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(                  // ✅ Wrap here
      child: Scaffold(
        backgroundColor: Colors.transparent,   // ✅ Transparent background
        appBar: AppBar(
          title: Text('Detected Symptoms'),
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Symptom Analysis:\n\n• Brown spots\n• Soft texture',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 12, 10, 10)),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(
                        imageUrl: 'https://via.placeholder.com/150',
                      ),
                    ),
                  );
                },
                child: Text('Result'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
