import 'package:flutter/material.dart';
import 'package:kutubxona/config/theme/app_colors.dart';

class GenderSelector extends StatelessWidget {
  final List<String> genders;
  final String? selectedGender;
  final ValueChanged<String?> onChanged;
  final String? hintText;

  const GenderSelector({
    super.key,
    required this.genders,
    required this.selectedGender,
    required this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      borderRadius: BorderRadius.circular(16),
      dropdownColor: Theme.of(context).colorScheme.surface,
      value: selectedGender,
      hint: Text(
        hintText ?? 'Эркак',
        style: TextStyle(
          color: AppColors().hintColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      items:
          genders.map((gender) {
            return DropdownMenuItem(value: gender, child: Text(gender));
          }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors().border),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors().border),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors().border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors().border),
        ),
      ),
    );
  }
}
