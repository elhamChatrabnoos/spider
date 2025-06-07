import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/network/response_status.dart';
import 'package:sockettest/features/accounting/models/get_transactions_response.dart';
import 'package:sockettest/features/accounting/repository/accounting_repository.dart';

class AccountingPageController extends GetxController {
  RequestStatus getTransactionsStatus = RequestStatus();
  final String transactionsUpdateKey = 'getTransactionsUpdateKey';
  AccountingRepository accountingRepository = AccountingRepository();

  List<Transaction> transactionList = [];

  Future<void> getTransactions({required int pageNumber, bool? getMore}) async {
    if (!(getMore ?? false)) {
      this.pageNumber = 1;
      getTransactionsStatus.loading();
      update([transactionsUpdateKey]);
    }

    final responseState =
        await accountingRepository.getTransactions(pageNumber);

    if (responseState is ResponseSuccess<GetTransactionsResponse>) {
      totalPages = responseState.data?.data?.all ?? 1;

      if (getMore ?? false) {
        transactionList.addAll(responseState.data?.data?.invoices ?? []);
      } else {
        transactionList = responseState.data?.data?.invoices ?? [];
      }

      getTransactionsStatus.success();
      update([transactionsUpdateKey]);
    }
    if (responseState is ResponseFailed) {
      getTransactionsStatus.error('${responseState.error}', showMessage: false);
      update([transactionsUpdateKey]);
    }
  }

  ScrollController scrollController = ScrollController();
  int pageNumber = 1;
  int totalPages = 1;

  void listenToScroll() {
    scrollController.addListener(
      () {
        if (scrollController.position.maxScrollExtent >
            scrollController.position.pixels) {
          if (pageNumber < totalPages) {
            pageNumber += 1;
            getTransactions(pageNumber: pageNumber, getMore: true);
          }
        }
      },
    );
  }

  @override
  void onInit() {
    listenToScroll();
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
