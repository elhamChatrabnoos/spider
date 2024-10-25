import 'package:get/get.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/network/response_status.dart';
import 'package:sockettest/features/accounting/models/get_transactions_response.dart';
import 'package:sockettest/features/accounting/repository/accounting_repository.dart';

class AccountingPageController extends GetxController {
  RequestStatus getTransactionsStatus = RequestStatus();
  final String transactionsUpdateKey = 'getTransactionsUpdateKey';

  List<Transaction> transactionList = [];

  Future<void> getTransactions() async {
    getTransactionsStatus.loading();
    update([transactionsUpdateKey]);

    AccountingRepository accountingRepository = AccountingRepository();
    final responseState = await accountingRepository.getTransactions();

    if (responseState is ResponseSuccess<GetTransactionsResponse>) {
      getTransactionsStatus.success();
      transactionList =
          responseState.data?.data?.transactions?.reversed.toList() ?? [];
      update([transactionsUpdateKey]);
    }
    if (responseState is ResponseFailed) {
      getTransactionsStatus.error('${responseState.error}', showMessage: false);
      update([transactionsUpdateKey]);
    }
  }

  @override
  void onInit() {
    getTransactions();
    super.onInit();
  }

  /// add new item to list
  void addItemToList(Transaction account) {
    transactionList.insert(0, account);
    update([transactionsUpdateKey]);
  }

  void addTransaction(Transaction transaction) {
    transactionList.insert(0, transaction);
    update([transactionsUpdateKey]);
  }
}
