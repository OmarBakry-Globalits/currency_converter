import 'package:flutter/material.dart';

import 'consts.dart';

class CustomDropDown extends StatelessWidget {
  final void Function(String?)? onChanged;
  final String? value;
  const CustomDropDown({super.key,required this.onChanged,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 0.8),
            borderRadius: BorderRadius.circular(10)),
        child: DropdownButton<String>(
            value:value,
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 14,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            isExpanded: true,
            underline: const SizedBox.shrink(),
            onChanged: onChanged,
            items: Constants.currencies.entries
                .map((e) => DropdownMenuItem(value: e.key, child: Text(e.key)))
                .toList()),
      ),
    );
  }
}
