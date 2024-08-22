import 'package:logger/logger.dart';

class AppHelper{

  static Logger log = Logger();

  static customPrint(String message){
    log.w(message);
  }


}