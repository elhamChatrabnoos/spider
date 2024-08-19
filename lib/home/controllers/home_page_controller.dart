import 'dart:async';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomePageController extends GetxController {
  RxList<String> receivedMessage1 = RxList([]);
  RxString errorMsg = ''.obs;
  RxList<dynamic> historyList = RxList([]);

  RxBool isSocketConnect = false.obs;

  late Socket socket;
  final StreamController<String> _streamController = StreamController<String>();

  Stream<String> get messagesStream => _streamController.stream;

  Future<void> reconnectSocket() async {
    errorMsg('');
    receivedMessage1.clear();
    socket.disconnect();
    socket.dispose();
    connectSocket();
  }

  Future<void> connectSocket() async {
    print('try to connect...');
    isSocketConnect(false);

    socket = io("https://test.spider-cryptobot.site", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    _socketListeners();
  }

  void _socketListeners() {
    socket.onConnect((_) {
      isSocketConnect(true);
      print("Connection established");
    });

    socket.on('backData', (data) {
      print(data);
      receivedMessage1.add(data['data']);
    });

    socket.on('backData2', (data) {
      receivedMessage1.add(data['data']);
      print(data);
    });

    socket.onDisconnect((_) {
      isSocketConnect(false);
      print("connection Disconnect");
    });

    socket.onError((err) {
      errorMsg('Error occur when connect to socket: $err');
      print('on error $err');
    });
  }

  void getHistoryList() {
    socket.emit('get');

    socket.on('history', (data) {
      List receivedList = data['data'];
      // print(receivedList);
      // List<String> list = [];
      // receivedList.map((e) => list.add(e));
      historyList(receivedList);
      print(historyList.length);
    });
  }
}
