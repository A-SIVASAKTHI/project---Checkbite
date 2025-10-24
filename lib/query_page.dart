import 'package:flutter/material.dart';
import 'background_wrapper.dart';

class QueryPage extends StatefulWidget {
  const QueryPage({super.key});

  @override
  State<QueryPage> createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String message = '';

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Submit a Query"),
          backgroundColor: Colors.blue.shade700,
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Card(
              color: Colors.white.withOpacity(0.9),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Let us know your questions or issues",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Your Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter your name' : null,
                        onSaved: (value) => name = value!,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter email' : null,
                        onSaved: (value) => email = value!,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Message',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                        validator: (value) =>
                            value!.isEmpty ? 'Enter your message' : null,
                        onSaved: (value) => message = value!,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Query Submitted Successfully!"),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
