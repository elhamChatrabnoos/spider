import 'package:dio/dio.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/network/api_addresses.dart';
import 'package:sockettest/app/network/response_status.dart';
import 'package:sockettest/app/network/server_response.dart';
import 'package:sockettest/features/accounting/models/get_transactions_response.dart';
import 'package:sockettest/features/accounts/models/get_account_response.dart';

class AccountingRepository {
  /// get all transaction
  Future<ResponseStatus<GetTransactionsResponse>> getTransactions() async {
    try {
      final response =
          await AppHelper.dioConfig.dio.get(ApiAddresses.getTransactions);
      final GetTransactionsResponse model =
          GetTransactionsResponse.fromJson(response.data);
      return ResponseSuccess(model);
    } on DioException catch (error) {
      return ResponseFailed(AppHelper.checkException(error));
    }
  }

  /// add account
  Future<ResponseStatus<String>> addTransaction({
    required Transaction transaction,
  }) async {
    try {
      AppHelper.customPrint(transaction.amount);

      var response;
      if (transaction.type == 0) {
        response = await AppHelper.dioConfig.dio.put(
          '${ApiAddresses.withDraw}/${transaction.account}',
          data: {
            "amount": int.tryParse(transaction.amount.toString().replaceAll(',', '')),
            "cause": transaction.transActionCause,
          },
        );
      } else {
        response = await AppHelper.dioConfig.dio.put(
          '${ApiAddresses.deposit}/${transaction.account}',
          data: {
            "amount": int.tryParse(transaction.amount.toString().replaceAll(',', '')),
            "cause": transaction.transActionCause,
          },
        );
      }

      final ServerResponse model = ServerResponse.fromJson(response.data);
      if (model.success ?? false) {
        return ResponseSuccess('Transaction added successful.');
      } else {
        return ResponseFailed(model.error ?? 'Error');
      }
    } on DioException catch (error) {
      return ResponseFailed(AppHelper.checkException(error));
    }
  }
}
