import 'package:flutter/material.dart';
import 'package:kutubxona/features/widgets/custom_selecter.dart';

class GenderDropdown extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onChanged;

  const GenderDropdown({
    Key? key,
    required this.selectedGender,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      label: 'Жинс',
      hintText: 'Жинс',
      items: ['male', 'famale'],
      selectedItem: selectedGender,
      onChanged: onChanged,
    );
  }
}
