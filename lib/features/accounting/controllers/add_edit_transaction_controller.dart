import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/config/app_helper.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/network/response_status.dart';
import 'package:sockettest/app/network/server_response.dart';
import 'package:sockettest/features/accounting/controllers/accounting_page_controller.dart';
import 'package:sockettest/features/accounting/models/get_transactions_response.dart';
import 'package:sockettest/features/accounting/models/reasons_response_model.dart';
import 'package:sockettest/features/accounting/repository/accounting_repository.dart';

class AddEditTransactionDialogController extends GetxController {
  TextEditingController reasonController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  /// account name
  String? selectedAccountName;
  final String accountNameUpdateKey = 'accountNameUpdateKey';

  changeAccountName(String accountName) {
    selectedAccountName = accountName;
    update([accountNameUpdateKey]);
  }

  /// status
  String? selectedStatus;
  final String selectStatusUpdateKey = 'selectStatusUpdateKey';

  changeStatus(String status) {
    selectedStatus = status;
    update([selectStatusUpdateKey]);
  }

  /// add new transaction
  RequestStatus addTransactionStatus = RequestStatus();
  final String addTransactionUpdateKey = 'addTransactionUpdateKey';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> addNewTransaction() async {
    addTransactionStatus.loading();
    update([addTransactionUpdateKey]);

    Transaction transaction = Transaction(
      type: selectedStatus,
      amount: int.tryParse(amountController.text.replaceAll(',', '')),
      cause: Cause(causes: reasonController.text),
    );

    AccountingRepository accountingRepository = AccountingRepository();
    final responseState =
        await accountingRepository.addTransaction(transaction: transaction);

    if (responseState is ResponseSuccess<ServerResponse>) {
      transaction.createdAt = responseState.data!.timestamp;
      Get.back();
      /// add transaction locally to transaction list
      Get.find<AccountingPageController>().addTransaction(transaction);
      addTransactionStatus.success(
          message: responseState.data?.message, title: 'Success');
      update([addTransactionUpdateKey]);
    }
    if (responseState is ResponseFailed) {
      Get.back();
      addTransactionStatus.error('${responseState.error}', showMessage: true);
      update([addTransactionUpdateKey]);
    }
  }

  /// get reasons
  RequestStatus getReasonsStatus = RequestStatus();
  final String getReasonsUpdateKey = 'getReasonsUpdateKey';
  List<Reason> reasonsList = [];

  Future<void> getReasons() async {
    getReasonsStatus.loading();
    update([getReasonsUpdateKey]);

    AccountingRepository accountingRepository = AccountingRepository();
    final responseState = await accountingRepository.getReasons();

    if (responseState is ResponseSuccess<ReasonsResponse>) {
      reasonsList = responseState.data?.data ?? [];
      getReasonsStatus.success();
      update([getReasonsUpdateKey]);
    }
    if (responseState is ResponseFailed) {
      getReasonsStatus.error('${responseState.error}', showMessage: false);
      update([getReasonsUpdateKey]);
    }
  }

  @override
  void onInit() {
    // getReasons();
    super.onInit();
  }
}
