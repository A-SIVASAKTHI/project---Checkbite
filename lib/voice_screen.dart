import 'package:flutter/material.dart';
import 'voice_helper.dart';

class VoiceScreen extends StatefulWidget {
  @override
  _VoiceScreenState createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  VoiceHelper voice = VoiceHelper();
  String voiceText = "";

  @override
  void initState() {
    super.initState();
    voice.initSTT();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice Input")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              voiceText.isEmpty ? "Say something..." : voiceText,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),

            // MIC BUTTON
            GestureDetector(
              onTapDown: (_) {
                voice.startListening((text) {
                  setState(() => voiceText = text);
                });
              },
              onTapUp: (_) {
                voice.stopListening();
              },
              child: CircleAvatar(
                radius: 40,
                backgroundColor:
                    voice.isListening ? Colors.red : Colors.blue,
                child: const Icon(Icons.mic, color: Colors.white, size: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
