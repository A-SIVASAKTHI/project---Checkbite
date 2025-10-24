import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'background_wrapper.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent, // ✅ allow background image to show
        appBar: AppBar(
          title: const Text("Scan History"),
          backgroundColor: Colors.teal, // optional: for visibility
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('scan_history')
              .orderBy('timestamp', descending: true)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No scans found", style: TextStyle(color: Colors.white)));
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                final imageUrl = data['image_url'];
                final timestamp = (data['timestamp'] as Timestamp).toDate();

                return Card(
                  margin: const EdgeInsets.all(10),
                  color: Colors.white.withOpacity(0.8), // ✅ semi-transparent for better readability
                  child: Column(
                    children: [
                      Image.network(imageUrl),
                      const SizedBox(height: 5),
                      Text(
                        'Scanned on: ${timestamp.toLocal()}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
