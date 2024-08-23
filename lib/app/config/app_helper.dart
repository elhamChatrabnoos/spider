import 'package:logger/logger.dart';

class AppHelper{


  static customPrint(String message){
    Logger log = Logger();
    log.w(message);
  }


}