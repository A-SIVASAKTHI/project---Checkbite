import 'package:flutter/material.dart';
import 'scan_page.dart';
import 'contact_page.dart';
import 'query_page.dart';
import 'background_wrapper.dart';

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 46, 153, 174),
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Image.asset('assets/logo.png', height: 48, width: 70),
              const SizedBox(width: 10),
              const Text(
                'CHECKBITE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  letterSpacing: 1,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.grid_view, size: 28, color: Colors.white),
              onSelected: (value) {
                if (value == 'Scan') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ScanPage()),
                  );
                } else if (value == 'Contact') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ContactPage()),
                  );
                } else if (value == 'Query') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QueryPage()),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return ['Scan', 'Contact', 'Query'].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(
                      choice,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              children: [
                const Text(
                  'Welcome to CheckBite 🍽️',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Detect food safety, get health suggestions, and connect with us — all in one place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 25),

                // --- Feature Cards (Attractive Style) ---
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                  children: [
                    _buildFeatureCard(
                      context,
                      emoji: '🍏',
                      title: 'Scan Food',
                      desc: 'Check food safety',
                      color: Colors.greenAccent.shade400,
                      page: const ScanPage(),
                    ),
                    _buildFeatureCard(
                      context,
                      emoji: '📜',
                      title: 'View History',
                      desc: 'Previous scans',
                      color: Colors.purpleAccent.shade400,
                    ),
                    _buildFeatureCard(
                      context,
                      emoji: '📞',
                      title: 'Contact Us',
                      desc: 'Reach our team',
                      color: Colors.orangeAccent.shade400,
                      page: const ContactPage(),
                    ),
                    _buildFeatureCard(
                      context,
                      emoji: '❓',
                      title: 'Raise Query',
                      desc: 'Ask questions',
                      color: Colors.blueAccent.shade400,
                      page: const QueryPage(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required String emoji,
      required String title,
      required String desc,
      required Color color,
      Widget? page}) {
    return GestureDetector(
      onTap: page != null
          ? () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => page));
            }
          : null,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 130, // compact but slightly taller for emoji
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: const Offset(2, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular Emoji
              Container(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 3),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
