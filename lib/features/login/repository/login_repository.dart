import 'package:dio/dio.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/network/api_addresses.dart';
import 'package:sockettest/app/network/response_status.dart';
import 'package:sockettest/features/login/models/login_response_model.dart';

class LoginRepository {
  Future<ResponseStatus<LoginResponseModel>> loginUser(String password) async {
    try {
      final response = await AppHelper.dioConfig.dio
          .post(ApiAddresses.login, data: {"password": password});
      final LoginResponseModel model = LoginResponseModel.fromJson(response.data);
      return ResponseSuccess(model);
    } on DioException catch (error) {
      return ResponseFailed(AppHelper.checkException(error));
    }
  }
}
