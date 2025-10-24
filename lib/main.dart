import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'main_home_page.dart';
import 'scan_page.dart';
import 'symptom_page.dart';
import 'result_page.dart';
import 'feedback_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckBite',
      initialRoute: '/', // 👈 HomePage is the starting page
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/mainhome': (context) => MainHomePage(),
        '/scan': (context) => const ScanPage(), // ✅ fixed: no camera param
        '/symptom': (context) => SymptomPage(),
        '/result': (context) => ResultPage(imageUrl: ''),
        '/feedback': (context) => FeedbackPage(),
      },
    );
  }
}
