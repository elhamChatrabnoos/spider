import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RecordVoiceController extends GetxController {

  @override
  void onInit() {
    startListening();
    super.onInit();
  }

  SpeechToText _speechToText = SpeechToText();
  RxBool speechEnabled = false.obs;
  RxBool listeningStarted = false.obs;
  RxString lastWords = ''.obs;
  bool controllerRemoved = false;


  void startListening() async {
    controllerRemoved = (false);
    speechEnabled.value = await _speechToText.initialize(
      onError: (errorNotification) => stopListening(),
      onStatus: (status) {
        AppHelper.customPrint(status);
      },
    );
    lastWords('');
    if (speechEnabled.value) {
      final options = SpeechListenOptions(
        cancelOnError: true,
        partialResults: true,
        autoPunctuation: true,
        enableHapticFeedback: true,
        listenMode: ListenMode.deviceDefault,
      );

      listeningStarted(true);
      await _speechToText.listen(
        listenOptions: options,
        onResult: _onSpeechResult,
        listenFor: Duration(seconds: 10),
        onSoundLevelChange: (level) async {
          if (level < 0) {
            await Future.delayed(
              Duration(seconds: 3),
              () async{
                if (level < 0 && lastWords.value.isEmpty) await stopListening();
              },
            );
          }
        },
      );

      AppHelper.customPrint('start listening...');
    } else {
      Get.snackbar('Error', 'Can\'t record sound');
    }
  }

  Future stopListening() async {
    await _speechToText.stop();
    listeningStarted(false);
    if(!controllerRemoved){
      controllerRemoved = true;
      Get.delete<RecordVoiceController>();
      Get.back(result: lastWords.value);
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) async {
    lastWords.value = result.recognizedWords;
    AppHelper.customPrint('last words $lastWords');
    if (result.finalResult) {
      await stopListening();
    }
  }

  @override
  void dispose() {
    lastWords('');
    _speechToText.cancel();
    super.dispose();
  }
}
