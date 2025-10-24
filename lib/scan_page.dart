import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'symptom_page.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      await _cameraController!.initialize();

      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint("Camera error: $e");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // ✅ Foreground content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Camera Preview",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 220,
                  height: 280,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _isCameraInitialized
                        ? CameraPreview(_cameraController!)
                        : Container(
                            color: Colors.black26,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Scan', style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SymptomPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
