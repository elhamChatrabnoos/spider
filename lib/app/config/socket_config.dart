import 'package:socket_io_client/socket_io_client.dart';

import 'app_helper.dart';

class SocketConfig{
  static late Socket socket;

  static Future<void> connectSocket() async {
    AppHelper.customPrint('try to connect...');

    socket = io("https://test.spider-cryptobot.site", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
  }
}