import 'package:logger/logger.dart';

class AppHelper{


  static customPrint(dynamic message){
    Logger log = Logger();
    log.w(message.toString());
  }


}