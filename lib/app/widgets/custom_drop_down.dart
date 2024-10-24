import 'package:flutter/material.dart';

class CustomDropDownField extends StatelessWidget {
  const CustomDropDownField({
    super.key,
    this.onChanged,
    this.value,
    required this.targetList,
    required this.hintText,
  });

  final void Function(String?)? onChanged;
  final String? value;
  final List<String> targetList;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.onTertiary,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              menuMaxHeight: 200,
              dropdownColor: Theme.of(context).colorScheme.primaryContainer,
              padding: const EdgeInsets.only(left: 20, right: 10),
              borderRadius: BorderRadius.circular(12),
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
              value: value,
              hint: Text(hintText),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
              items: targetList.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
