import 'package:get/get.dart';
import 'package:sockettest/app/config/local_db.dart';
import 'package:sockettest/app/network/request_status.dart';
import 'package:sockettest/app/network/response_status.dart';
import 'package:sockettest/features/accounts/models/get_account_response.dart';
import 'package:sockettest/features/accounts/repository/accounts_repository.dart';
import 'package:sockettest/features/home/views/pages/home_page.dart';
import 'package:sockettest/features/login/models/login_response_model.dart';
import 'package:sockettest/features/login/repository/login_repository.dart';
import 'package:sockettest/features/main/views/pages/main_page.dart';

class LoginController extends GetxController {
  RequestStatus loginUserStatus = RequestStatus();
  final String loginUserUpdateKey = 'loginUserUpdateKey';

  LoginResponseModel loginResponse = LoginResponseModel();

  Future<void> loginUser(String password) async {
    loginUserStatus.loading();
    update([loginUserUpdateKey]);

    LoginRepository loginRepository = LoginRepository();
    final responseState = await loginRepository.loginUser(password);

    if (responseState is ResponseSuccess<LoginResponseModel>) {
      loginUserStatus.success();
      loginResponse = responseState.data ?? LoginResponseModel();
      await LocalDb.saveAccessToken(loginResponse.data?.token);
      update([loginUserUpdateKey]);
      Get.off(MainPage());
    }
    if (responseState is ResponseFailed) {
      loginUserStatus.error('${responseState.error}', showMessage: true);
      update([loginUserUpdateKey]);
    }
  }

}
