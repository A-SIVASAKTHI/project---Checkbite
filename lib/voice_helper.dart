import 'package:speech_to_text/speech_to_text.dart';

class VoiceHelper {
  final SpeechToText stt = SpeechToText();
  bool isListening = false;
  String text = "";

  Future<bool> initSTT() async {
    return await stt.initialize();
  }

  void startListening(Function(String) onText) {
    isListening = true;
    stt.listen(
      onResult: (result) {
        text = result.recognizedWords;
        onText(text); // send text to UI
      },
    );
  }

  void stopListening() {
    isListening = false;
    stt.stop();
  }
}
