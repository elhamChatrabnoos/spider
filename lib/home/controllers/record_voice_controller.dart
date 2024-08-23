import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RecordVoiceController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  SpeechToText _speechToText = SpeechToText();
  RxBool speechEnabled = false.obs;
  RxBool listeningStarted = false.obs;
  RxString lastWords = ''.obs;

  void startListening() async {
    speechEnabled.value = await _speechToText.initialize();
    lastWords('');
    if (speechEnabled.value) {
      // final options = SpeechListenOptions(
      //   listenMode: ListenMode.confirmation,
      //   // cancelOnError: true,
      //   partialResults: true,
      //   autoPunctuation: true,
      //   enableHapticFeedback: true,
      // );
      listeningStarted(true);
      await _speechToText.listen(
        listenOptions:
            SpeechListenOptions(sampleRate: 1, autoPunctuation: false),
        onResult: _onSpeechResult,
      );

      AppHelper.customPrint('start listening...');
    } else {
      Get.snackbar('Error', 'No permission found for record sound');
    }
  }

  Future stopListening() async {
    await _speechToText.stop();
    await Future.delayed(Duration(seconds: 2));
    listeningStarted(false);
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    lastWords.value = result.recognizedWords;
    if (result.finalResult) {
      await stopListening();
      Get.delete<RecordVoiceController>();
      Get.back(result: lastWords.value);
    }
  }

  @override
  void dispose() {
    lastWords('');
    _speechToText.cancel();
    super.dispose();
  }
}
