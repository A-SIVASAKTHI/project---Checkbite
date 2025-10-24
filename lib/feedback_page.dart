import 'package:flutter/material.dart';
import 'background_wrapper.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _submitted = false;

  void _submitFeedback() {
    if (_rating == 0 || _commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please give a rating and comment")),
      );
      return;
    }

    setState(() {
      _submitted = true;
    });

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400, // 👈 Keeps it compact on large screens
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: _submitted
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Thank you for your feedback!',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            'Redirecting in 5 seconds...',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Rate your experience',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return IconButton(
                                onPressed: () {
                                  setState(() {
                                    _rating = index + 1;
                                  });
                                },
                                icon: Icon(
                                  Icons.star,
                                  size: 32,
                                  color: index < _rating
                                      ? Colors.amber
                                      : Colors.white24,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _commentController,
                            maxLines: 3,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Enter your comments...",
                              hintStyle:
                                  const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.black26,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _submitFeedback,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 46, 153, 174),
                              ),
                              child: const Text("Submit"),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
