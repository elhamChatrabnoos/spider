import 'package:dio/dio.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/network/api_addresses.dart';
import 'package:sockettest/app/network/response_status.dart';
import 'package:sockettest/app/network/server_response.dart';
import 'package:sockettest/features/accounting/models/get_transactions_response.dart';
import 'package:sockettest/features/accounting/models/reasons_response_model.dart';

class AccountingRepository {
  /// get all transaction
  Future<ResponseStatus<GetTransactionsResponse>> getTransactions(
      int pageNumber) async {
    try {
      final response = await AppHelper.dioConfig.dio.get(
        ApiAddresses.getTransactions,
        queryParameters: {"page": pageNumber},
      );
      final GetTransactionsResponse model =
          GetTransactionsResponse.fromJson(response.data);
      return ResponseSuccess(model);
    } on DioException catch (error) {
      return ResponseFailed(AppHelper.checkException(error));
    }
  }

  /// get reasons list
  Future<ResponseStatus<ReasonsResponse>> getReasons() async {
    try {
      final response = await AppHelper.dioConfig.dio.get(ApiAddresses.reasons);
      final ReasonsResponse model = ReasonsResponse.fromJson(response.data);
      return ResponseSuccess(model);
    } on DioException catch (error) {
      return ResponseFailed(AppHelper.checkException(error));
    }
  }

  /// add transaction
  Future<ResponseStatus<ServerResponse>> addTransaction({
    required Transaction transaction,
  }) async {
    try {
      var response;
      response = await AppHelper.dioConfig.dio.post(
        ApiAddresses.invoice,
        data: {
          "amount":
              int.tryParse(transaction.amount.toString().replaceAll(',', '')),
          "cause": transaction.cause?.causes,
          "type": transaction.type?.toLowerCase()
        },
      );

      final ServerResponse model = ServerResponse.fromJson(response.data);
      return ResponseSuccess(model);
    } on DioException catch (error) {
      return ResponseFailed(AppHelper.checkException(error));
    }
  }
}
