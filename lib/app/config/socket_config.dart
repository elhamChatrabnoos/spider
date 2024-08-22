import 'dart:io';

import 'package:socket_io_client/socket_io_client.dart';

class SocketConfig{
  static late Socket socket;

  static Future<void> connectSocket() async {
    print('try to connect...');

    socket = io("https://test.spider-cryptobot.site", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
  }
}