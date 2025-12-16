import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'symptom_page.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  bool _isCameraReady = false;

  // Speech-to-text
  late stt.SpeechToText speech;
  String voiceText = "";

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
    _initCamera();
  }

  // ---------------- CAMERA INITIALIZATION ----------------
  Future<void> _initCamera() async {
    // Ask for permission
    var status = await Permission.camera.request();
    if (!status.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Camera permission denied")),
        );
      }
      return;
    }

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        debugPrint("❌ No cameras found");
        return;
      }

      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (!mounted) return;

      setState(() => _isCameraReady = true);

    } catch (e) {
      debugPrint("Camera Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Camera Error: $e")),
        );
      }
    }
  }

  // ---------------- SPEECH FUNCTIONS ----------------
  Future<void> startListening() async {
    bool available = await speech.initialize();
    if (available) {
      speech.listen(onResult: (result) {
        setState(() {
          voiceText = result.recognizedWords;
        });
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Speech not available")),
        );
      }
    }
  }

  void stopListening() {
    speech.stop();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    speech.stop();
    super.dispose();
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Page"),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              "assets/background.jpg",
              fit: BoxFit.cover,
            ),
          ),

          // MAIN CONTENT
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Camera Preview",
                  style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 5, 3, 3)),
                ),
                const SizedBox(height: 10),

                // Camera box
                SizedBox(
                  width: 230,
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _isCameraReady && _cameraController != null
                        ? CameraPreview(_cameraController!)
                        : Container(
                            color: Colors.black26,
                            child: const Center(
                              child: CircularProgressIndicator(color: Colors.teal),
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 30),

                // BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SCAN BUTTON
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Scan",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SymptomPage()),
                        );
                      },
                    ),

                    const SizedBox(width: 15),

                    // MIC button
                    InkWell(
                      onTap: () async {
                        if (!speech.isListening) {
                          await startListening();
                        } else {
                          stopListening();
                        }
                        setState(() {});
                      },
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor:
                            speech.isListening ? Colors.red : Colors.teal,
                        child: const Icon(Icons.mic, size: 28, color: Colors.white),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Voice text output
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    voiceText.isEmpty ? "Speak something..." : voiceText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
