import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'background_wrapper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 🔐 LOGIN FUNCTION
  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();

      // Save username and email locally
      String username = _usernameController.text.trim();
      await prefs.setString("username", username);
      await prefs.setString("email", "$username@gmail.com");

      // Navigate to main home page
      Navigator.pushNamed(context, '/mainhome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent, // show background
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // 🔷 APP TITLE
                  const Text(
                    "CHECKBITE",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 🔷 USERNAME FIELD
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the username';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 🔷 PASSWORD FIELD
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔷 LOGIN BUTTON
                  SizedBox(
                    width: 250,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: loginUser,
                      child: const Text('Login'),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 🔷 SIGNUP LINK
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      'Don\'t have an account? Sign Up',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
