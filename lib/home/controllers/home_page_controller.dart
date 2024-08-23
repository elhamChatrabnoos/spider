import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/config/socket_config.dart';

class HomePageController extends GetxController {
  RxList<String> receivedMessage1 = RxList([]);
  RxString errorMsg = ''.obs;
  RxList<dynamic> historyList = RxList([]);
  RxBool isSocketConnect = false.obs;

  Future<void> reconnectSocket() async {
    errorMsg('');
    receivedMessage1.clear();
    SocketConfig.socket.disconnect();
    SocketConfig.socket.dispose();
    socketListeners();
  }

  /// listen to socket events
  void socketListeners() async {
    await _getSystemIp();
    await SocketConfig.connectSocket();

    SocketConfig.socket.onConnect((_) {
      isSocketConnect(true);
      AppHelper.customPrint("Connection established");
    });

    SocketConfig.socket.on('backData', (data) {
      AppHelper.customPrint(data);
      receivedMessage1.add(data['data']);
    });

    SocketConfig.socket.on('backData2', (data) {
      receivedMessage1.add(data['data']);
      AppHelper.customPrint(data);
    });

    SocketConfig.socket.on(
      'answer',
      (data) {
        AppHelper.customPrint('data: ${data['data']}');
        AppHelper.customPrint('message: ${data['message']}');

        receivedMessage1.add(data['data']);
        speak(data['message']);
      },
    );

    SocketConfig.socket.onDisconnect((_) {
      isSocketConnect(false);
      AppHelper.customPrint("connection Disconnect");
    });

    SocketConfig.socket.onError((err) {
      errorMsg('Error occur when connect to socket: $err');
      AppHelper.customPrint('on error $err');
    });
  }

  String ipAddress = '';

  Future<void> _getSystemIp() async {
    final info = NetworkInfo();
    ipAddress = await info.getWifiIP() ?? '';
    AppHelper.customPrint('Ip address : $ipAddress');
  }

  /// history dialog list
  void getHistoryList() {
    SocketConfig.socket.emit('get');
    SocketConfig.socket.on('history', (data) {
      List receivedList = data['data'];
      historyList(receivedList);
      AppHelper.customPrint(historyList.length.toString());
    });
  }

  @override
  onInit() {
    initTts();
    socketListeners();
    super.onInit();
  }

  /// send voice and set response
  void sendVoiceToServer(String targetText) {
    SocketConfig.socket.emit(
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

    flutterTts.setStartHandler(() {
      AppHelper.customPrint('start speaking');
    });

    flutterTts.setCompletionHandler(() {
      AppHelper.customPrint('speak complete');
    });

    flutterTts.setErrorHandler((msg) {
      AppHelper.customPrint('error when speak $msg');
    });
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
