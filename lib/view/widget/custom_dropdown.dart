import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String hintText;
  final void Function(String?) onChanged;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      underline: const Divider(
        color: Colors.grey, // Or use your kColorgrey
        thickness: 1,
        height: 1,
      ),
      value: items.contains(value) ? value : null,
      hint: Text(hintText),
      items: [
        DropdownMenuItem<String>(
          value: '',
          child: Text(hintText),
        ),
        ...items.map(
          (item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          ),
        )
      ],
      onChanged: onChanged,
    );
  }
}
