import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddEditDialogController extends GetxController{

  TextEditingController descriptionController = TextEditingController();
  TextEditingController costController = TextEditingController();


  /// account name
  String? selectedAccountName;
  final String accountNameUpdateKey = 'accountNameUpdateKey';

  changeAccountName(String accountName){

    selectedAccountName = accountName;
    update([accountNameUpdateKey]);
  }


  /// status
  String? selectedStatus;
  final String selectStatusUpdateKey = 'selectStatusUpdateKey';

  changeStatus(String status){
    selectedStatus = status;
    update([selectStatusUpdateKey]);
  }


}