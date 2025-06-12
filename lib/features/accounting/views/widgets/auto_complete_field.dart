import 'package:flutter/cupertino.dart' show BuildContext, Widget;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../app/config/app_helper.dart';
import '../../../../app/network/request_status.dart';
import '../../../../app/widgets/custom_text_field.dart';
import '../../controllers/add_edit_transaction_controller.dart';
import '../../models/reasons_response_model.dart';

class AutoCompleteField extends StatefulWidget {
  const AutoCompleteField({super.key});

  @override
  State<AutoCompleteField> createState() => _AutoCompleteFieldState();
}

class _AutoCompleteFieldState extends State<AutoCompleteField> {
  final GlobalKey _textFieldKey = GlobalKey();
  double _referenceWidth = 50;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          _textFieldKey.currentContext?.findRenderObject() as RenderBox?;

      if (renderBox != null) {
        setState(() {
          _referenceWidth = renderBox.size.width;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddEditTransactionDialogController>();
    return GetBuilder<AddEditTransactionDialogController>(
      id: Get.find<AddEditTransactionDialogController>().getReasonsUpdateKey,
      builder: (logic) {
        return Autocomplete<Reason>(
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            controller.reasonController = textEditingController;
            return CustomTextField(
              globalKey: _textFieldKey,
              focusNode: focusNode,
              checkValidation: (value) =>
                  AppHelper.checkValidation(value ?? ''),
              controller: textEditingController,
              hintText: 'Enter reason',
              enableBorder: true,
            );
          },
          optionsMaxHeight: MediaQuery.sizeOf(context).height / 2,
          optionsViewBuilder: (context, onSelected, options) {
            if (logic.getReasonsStatus.status == Status.success)
              return Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: _referenceWidth,
                  height: MediaQuery.sizeOf(context).height / 3.5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: options
                          .map(
                            (e) => InkWell(
                              onTap: () {
                                onSelected(e);
                                controller.reasonController.text =
                                    e.causes ?? '';
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              child: Text(e.causes ?? ''),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              );
            return SizedBox();
          },
          optionsBuilder: (textEditingValue) {
            if (logic.reasonsList.isEmpty) {
              return [];
            }
            return logic.reasonsList.where((element) =>
                element.causes!.contains(textEditingValue.text.toLowerCase()));
          },
        );
      },
    );
  }
}
