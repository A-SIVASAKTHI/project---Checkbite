import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'scan_page.dart';
import 'contact_page.dart';
import 'query_page.dart';
import 'background_wrapper.dart';
import 'profile_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  String usernameInitial = "U";

  @override
  void initState() {
    super.initState();
    loadProfileInitial();
  }

  Future<void> loadProfileInitial() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("username") ?? "User";

    setState(() {
      usernameInitial = name.isNotEmpty ? name[0].toUpperCase() : "U";
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 8,
          toolbarHeight: 70,
          backgroundColor: const Color(0xFF2E99AE),
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 45),
              const SizedBox(width: 12),
              const Text(
                'CHECKBITE',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          actions: [
            // --- Menu Icon without Circle ---
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: PopupMenuButton<String>(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 42,
                ),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                onSelected: (value) {
                  if (value == 'Scan') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ScanPage()));
                  } else if (value == 'Contact') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ContactPage()));
                  } else if (value == 'Query') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const QueryPage()));
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'Scan',
                    child: Text('Scan', style: TextStyle(fontSize: 18)),
                  ),
                  const PopupMenuItem(
                    value: 'Contact',
                    child: Text('Contact', style: TextStyle(fontSize: 18)),
                  ),
                  const PopupMenuItem(
                    value: 'Query',
                    child: Text('Query', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),

            // --- Profile Avatar ---
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfilePage()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Text(
                      usernameInitial,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: _buildHomeContent(context),
      ),
    );
  }

  // ---------------- BODY CONTENT ----------------
  Widget _buildHomeContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome to CheckBite 🍽️',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Your smart partner for food safety detection and health insights.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                height: 1.4,
                color: Colors.brown,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 35),
            _buildFeatureGrid(context),
          ],
        ),
      ),
    );
  }

  // ---------------- FEATURE CARDS GRID ----------------
  Widget _buildFeatureGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 18,
      mainAxisSpacing: 18,
      childAspectRatio: 0.95,
      children: [
        _buildFeatureCard(
          context,
          emoji: '🍏',
          title: 'Scan Food',
          desc: 'Check safety instantly',
          color: Colors.green.shade400,
          page: const ScanPage(),
        ),
        _buildFeatureCard(
          context,
          emoji: '📜',
          title: 'View History',
          desc: 'All previous scans',
          color: Colors.deepPurple.shade400,
        ),
        _buildFeatureCard(
          context,
          emoji: '📞',
          title: 'Contact Us',
          desc: 'We are here to help',
          color: Colors.orange.shade400,
          page: const ContactPage(),
        ),
        _buildFeatureCard(
          context,
          emoji: '❓',
          title: 'Raise Query',
          desc: 'Ask any question',
          color: Colors.blue.shade400,
          page: const QueryPage(),
        ),
      ],
    );
  }

  // ---------------- CARD UI ----------------
  Widget _buildFeatureCard(
    BuildContext context, {
    required String emoji,
    required String title,
    required String desc,
    required Color color,
    Widget? page,
  }) {
    return GestureDetector(
      onTap: page != null
          ? () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => page));
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.85),
              color.withOpacity(0.60),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(3, 4)),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.30),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(14),
              child: Text(emoji, style: const TextStyle(fontSize: 34)),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              desc,
              style: const TextStyle(fontSize: 13, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
