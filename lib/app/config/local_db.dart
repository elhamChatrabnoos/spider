
import 'app_constants.dart';
import 'app_helper.dart';

class LocalDb {

  static Future saveAccessToken(String token) async{
    AppHelper.localDbInfo.put(AppConstants.userAccessTokenKey, token);
  }

  static Future<String?> getAccessToken() async {
    return AppHelper.localDbInfo.get(AppConstants.userAccessTokenKey);
  }

  static Future deleteAccessToken() async {
    await AppHelper.localDbInfo.delete(AppConstants.userAccessTokenKey);
  }

  static Future saveRefreshToken(String token) async{
    AppHelper.localDbInfo.put(AppConstants.userRefreshTokenKey, token);
  }

  static Future<String?> getRefreshToken() async {
    return AppHelper.localDbInfo.get(AppConstants.userRefreshTokenKey);
  }


  static Future deleteRefreshToken() async {
    await AppHelper.localDbInfo.delete(AppConstants.userRefreshTokenKey);
  }

}