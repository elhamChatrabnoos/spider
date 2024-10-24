import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestStatus {
  Status status = Status.notCalled;
  String? _message;

  get message => _message ?? 'Error occurred';

  void loading() {
    status = Status.loading;
  }

  void success({
    String? message,
    String? title,
    SnackPosition? snackPosition,
    int durationSec = 2,
  }) {
    status = Status.success;
    if (message != null) {
      Get.snackbar(
        '',
        message,
        titleText: Text(
          title ?? '',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.green.withOpacity(0.5),
      );
    }
  }

  void notCalled() {
    status = Status.notCalled;
  }

  void error(
    String message, {
    bool showMessage = true,
    String title = 'Error',
    SnackPosition? snackPosition,
  }) {
    status = Status.error;
    _message = message;
    if (showMessage) {
      Get.snackbar(
        '',
        message,
        titleText: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        colorText: Colors.white,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red.withOpacity(0.5),
      );
    }
  }

  void clear() {
    status = Status.notCalled;
    _message = null;
  }
}

enum Status {
  notCalled,
  loading,
  success,
  error,
}
