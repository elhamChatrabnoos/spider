import 'package:flutter/material.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    this.onChanged,
    this.selectedItem,
    required this.targetList,
    super.key,
    required this.title,
    this.validator,
  });

  final void Function(String?)? onChanged;
  final String? selectedItem;
  final List<String> targetList;
  final String title;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 5),
        FormField<String>(
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select an item';
                }
                return null;
              },
          builder: (FormFieldState<String> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: state.hasError
                            ? Colors.red
                            : Theme.of(context).colorScheme.onSecondary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      selectedItemBuilder: (BuildContext context) {
                        return targetList.map<Widget>((String item) {
                          return Text(
                            textAlign: TextAlign.center,
                            item,
                          );
                        }).toList();
                      },
                      dropdownColor: Theme.of(context).colorScheme.tertiary,
                      menuMaxHeight: 200,
                      padding: const EdgeInsets.only(
                          left: 15, right: 10, bottom: 10, top: 10),
                      borderRadius: BorderRadius.circular(12),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          // color: Theme.of(context).colorScheme.tertiary,
                          ),
                      value: selectedItem,
                      hint: Text(
                        'Select',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        // color: Theme.of(context).colorScheme.primaryContainer,
                        size: 30,
                      ),
                      items: targetList.map((String style) {
                        return DropdownMenuItem<String>(
                          value: style,
                          child: Text(style,
                              style: Theme.of(context).textTheme.bodyMedium),
                        );
                      }).toList(),
                      onChanged: (value) {
                        state.didChange(value);
                        if (onChanged != null) {
                          onChanged!(value);
                        }
                      },
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
