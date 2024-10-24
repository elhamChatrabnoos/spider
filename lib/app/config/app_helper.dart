// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:sockettest/app/config/app_constants.dart';
import 'package:sockettest/app/network/dio_config.dart';

import '../widgets/error_dialog.dart';

// import '../network/dio_config.dart';
import 'app_text.dart';

class AppHelper {
  static Logger log = Logger();
  static DioConfig dioConfig = DioConfig();

  static var localDbInfo;

  static Future openLocalDb() async {
    localDbInfo = await Hive.openBox(AppConstants.hiveDb);
  }

  static String checkException(DioException error) {
    if (error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionTimeout ||
        error.response == null) {
      return AppConstants.someThingWrong;
    } else if (error.response!.statusCode == 500) {
      return AppConstants.someThingWrong;
    }
    return AppConstants.someThingWrong;
  }

  static customPrint(dynamic message) {
    Logger log = Logger();
    log.w(message.toString());
  }

  /// error dialog
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return ErrorDialog(errorMsg: message);
      },
    );
  }

  static String changeDateFormat(String value) {
    if (value.isNotEmpty) {
      DateTime dateTime = DateTime.parse(value);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    }
    return '';
  }

  static String checkDateIsCurrentOrYesterday(String value) {
    DateTime currentDateTime = DateTime.now();

    DateTime yesterday = currentDateTime.subtract(const Duration(days: 1));

    if (changeDateFormat(currentDateTime.toString()) ==
        changeDateFormat(value.toString())) {
      return 'Today';
    } else if (changeDateFormat(yesterday.toString()) ==
        changeDateFormat(value.toString())) {
      return 'Yesterday';
    }

    return changeDateFormat(value);
  }

  /// get current date
  static String getCurrentDate() {
    DateTime dateTime = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static double roundDoubleNumber(double number) {
    return double.parse(number.toStringAsFixed(2));
  }

  static String? checkValidation(String value) {
    if (value.isEmpty) {
      return AppTexts.emptyFieldError;
    }
    return null;
  }

  /// change time format
  static String changeTimeFormatToUtc(String time) {
    final DateFormat inputFormat = DateFormat('HH:mm');
    try {
      DateTime localDateTime = inputFormat.parse(time);
      DateTime today = DateTime.now();

      DateTime completeLocalDateTime = DateTime(
        today.year,
        today.month,
        today.day,
        localDateTime.hour,
        localDateTime.minute,
      );

      DateTime utcDateTime = completeLocalDateTime.toUtc();

      return utcDateTime.toString().replaceAll('.000Z', '');
    } catch (e) {
      return 'Invalid time';
    }
  }

  static String changeDateTimeToString(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(dateTime);
  }

  /// convert utc to normal
  static String changeUtcToNormalTime(String utcDate) {
    DateTime utcDateTime = DateTime.parse(utcDate);
    DateTime localDateTime = utcDateTime.toLocal();
    String hour = localDateTime.hour.toString();
    String minute = localDateTime.minute.toString();
    if (hour.length == 1) {
      hour = '0$hour';
    }
    if (minute.length == 1) {
      minute = '0$minute';
    }
    String formattedLocalTime = '$hour:$minute';
    return formattedLocalTime;
  }

  static String secureEmail(String email) {
    // Split the email into the local part and the domain part
    int atIndex = email.indexOf('@');
    if (atIndex == -1 || atIndex < 2) {
      return email;
    }

    String localPart = email.substring(0, atIndex);
    String domain = email.substring(atIndex);

    // Show the first two characters of the local part and obfuscate the rest
    String visiblePart = localPart.substring(0, 2);
    String obfuscatedPart = '*' * (localPart.length - 2);

    return '$visiblePart$obfuscatedPart$domain';
  }
}

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any previously formatted commas
    String newText = newValue.text.replaceAll(',', '');

    // Convert the cleaned-up string back to an integer
    if (newText.isEmpty) {
      return newValue;
    }

    // Format the number by adding commas
    final formattedText = NumberFormat("#,###").format(int.parse(newText));

    // Return the new formatted value, with the proper caret position
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
