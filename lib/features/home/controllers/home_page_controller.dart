import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:sockettest/app/config/app_helper.dart';

class HomePageController extends GetxController {
  RxList<String> receivedMessage1 = RxList([]);
  RxString errorMsg = ''.obs;
  RxList<dynamic> historyList = RxList([]);
  RxBool isSocketConnect = false.obs;
  late Socket socket;
  String ipAddress = '';

  Future<void> reconnectSocket() async {
    errorMsg('');
    receivedMessage1.clear();
    socket.disconnect();
    socket.dispose();
    socketListeners();
  }

  /// listen to socket events
  void socketListeners() async {
    await _getSystemIp();
    await connectSocket();

    socket.onConnect((_) {
      isSocketConnect(true);
      AppHelper.customPrint("Connection established");
    });

    socket.on('backData', (data) {
      receivedMessage1.add(data['data']);
    });

    socket.on('backData2', (data) {
      receivedMessage1.add(data['data']);
    });

    socket.on(
      'answer',
      (data) {
        AppHelper.customPrint('data: ${data['data']}');
        AppHelper.customPrint('message: ${data['message']}');

        receivedMessage1.add(data['data']);
        speak(data['message']);
      },
    );

    socket.onDisconnect((_) {
      isSocketConnect(false);
      AppHelper.customPrint("connection Disconnect");
    });

    socket.onError((err) {
      errorMsg('Error occur when connect to socket: $err');
      AppHelper.customPrint('on error $err');
    });
  }

  Future<void> connectSocket() async {
    AppHelper.customPrint('try to connect...');

    socket = io(
        'https://test.spider-cryptobot.site',
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({
              'MACAddress': ipAddress,
            }) // optional
            .build());
    socket.connect();
  }

  Future<void> _getSystemIp() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    ipAddress = deviceInfo.data['version']['incremental'];
  }

  /// history dialog list
  void getHistoryList() {
    socket.emit('get');
    socket.on('history', (data) {
      List receivedList = data['data'];
      historyList(receivedList);
      AppHelper.customPrint(historyList.length.toString());
    });
  }

  @override
  onInit() {
    // initTts();
    // socketListeners();
    super.onInit();
  }

  /// send voice and set response
  void sendVoiceToServer(String targetText) {
    socket.emit(
      'message',
      {
        'data': targetText,
        'ipAddress': ipAddress,
      },
    );
    AppHelper.customPrint('emit $targetText');
  }

  /// change response to speech
  FlutterTts flutterTts = FlutterTts();

  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.45;

  Future<void> _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future<void> _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  void initTts() {
    flutterTts = FlutterTts();
    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }
  }

  Future<void> speak(String text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    await flutterTts.speak(text);
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  @override
  void dispose() {
    flutterTts.stop();
    flutterTts.clearVoice();
    super.dispose();
  }
}
