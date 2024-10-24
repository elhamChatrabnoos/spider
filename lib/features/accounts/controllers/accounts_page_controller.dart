import 'package:get/get.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/network/response_status.dart';
import 'package:sockettest/features/accounts/models/get_account_response.dart';
import 'package:sockettest/features/accounts/repository/accounts_repository.dart';

class AccountsPageController extends GetxController {
  RequestStatus getAccountStatus = RequestStatus();
  final String getAccountsUpdateKey = 'getAccountsUpdateKey';

  List<Account> accountsList = [];

  Future<void> getAccounts() async {

    getAccountStatus.loading();
    update([getAccountsUpdateKey]);

    AccountsRepository accountsRepository = AccountsRepository();
    final responseState = await accountsRepository.getAccounts();

    if (responseState is ResponseSuccess<GetAccountResponse>) {
      getAccountStatus.success();
      accountsList = responseState.data?.data?.accounts?.reversed.toList() ?? [];
      update([getAccountsUpdateKey]);
    }
    if (responseState is ResponseFailed) {
      getAccountStatus.error('${responseState.error}', showMessage: false);
      update([getAccountsUpdateKey]);
    }
  }

  @override
  void onInit() {
    getAccounts();
    super.onInit();
  }

  /// add new item to list
  void addItemToList(Account account) {
    accountsList.insert(0, account);
    update([getAccountsUpdateKey]);
  }

}
