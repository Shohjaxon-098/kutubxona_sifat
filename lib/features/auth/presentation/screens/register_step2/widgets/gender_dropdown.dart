import 'package:flutter/material.dart';
import 'package:kutubxona/features/widgets/custom_selecter.dart';

class GenderDropdown extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onChanged;

  const GenderDropdown({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropdown(
      label: "Жинс",
      items: const ["Male", "Famale"],
      selectedItem: selectedGender,
      onChanged: onChanged,
      hintText: "Жинс",
    );
  }
}
