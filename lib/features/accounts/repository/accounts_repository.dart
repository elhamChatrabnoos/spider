import 'package:dio/dio.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/network/api_addresses.dart';
import 'package:sockettest/app/network/response_status.dart';
import 'package:sockettest/app/network/server_response.dart';
import 'package:sockettest/features/accounts/models/get_account_response.dart';

class AccountsRepository {
  /// get all accounts
  Future<ResponseStatus<GetAccountResponse>> getAccounts() async {
    try {
      final response =
          await AppHelper.dioConfig.dio.get(ApiAddresses.getAccounts);
      final GetAccountResponse model =
          GetAccountResponse.fromJson(response.data);
      return ResponseSuccess(model);
    } on DioException catch (error) {
      return ResponseFailed(AppHelper.checkException(error));
    }
  }

  /// add account
  Future<ResponseStatus<String>> addAccount({
    required String name,
    required String password,
    required int balance,
  }) async {
    try {
      final response =
          await AppHelper.dioConfig.dio.post(ApiAddresses.addAccount, data: {
            "name" : name,
            "password" : password,
            "balance" : balance,
          });
      final ServerResponse model = ServerResponse.fromJson(response.data);
      if(model.success ?? false) {
        return ResponseSuccess(model.data ?? 'Success');
      }
      else{
        return ResponseFailed(model.error ?? 'Error');
      }
    } on DioException catch (error) {
      return ResponseFailed(AppHelper.checkException(error));
    }
  }


}
