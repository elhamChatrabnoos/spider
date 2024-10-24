import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key, this.onChanged, this.controller});

  final Function(String?)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      onChanged: onChanged,
      borderRaduis: 16,
      prefixIcon: Icon(
        Icons.search,
        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
        size: 25,
      ),
      enableBorder: false,
      hintText: 'Search',
      hintColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
      fillColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.05),
    );
  }

}
