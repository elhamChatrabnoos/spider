import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/network/response_status.dart';
import 'package:sockettest/features/accounting/controllers/accounting_page_controller.dart';
import 'package:sockettest/features/accounting/models/get_transactions_response.dart';
import 'package:sockettest/features/accounting/repository/accounting_repository.dart';

class AddEditTransactionDialogController extends GetxController {
  TextEditingController descriptionController = TextEditingController();
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
      account: selectedAccountName,
      type: selectedStatus?.toLowerCase() == 'withdraw' ? 0 : 1,
      amount: int.tryParse(amountController.text),
      transActionCause: descriptionController.text,
    );

    AccountingRepository accountingRepository = AccountingRepository();
    final responseState =
        await accountingRepository.addTransaction(transaction: transaction);

    if (responseState is ResponseSuccess<String>) {
      Get.back();
      descriptionController.text = '';
      amountController.text = '';
      selectedAccountName = null;
      selectedStatus = null;
      addTransactionStatus.success(
          message: responseState.data, title: 'Success');

      /// add transaction locally to transaction list
      Get.find<AccountingPageController>().addTransaction(transaction);
      update([addTransactionUpdateKey]);
    }
    if (responseState is ResponseFailed) {
      Get.back();
      descriptionController.text = '';
      amountController.text = '';
      selectedAccountName = null;
      selectedStatus = null;
      addTransactionStatus.error('${responseState.error}', showMessage: true);
      update([addTransactionUpdateKey]);
    }
  }
}
