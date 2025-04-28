import 'package:kutubxona/core/constants/important.dart';

Widget search({
  void Function(String)? onChanged,
  TextEditingController? controller,
  FocusNode? focusNode,
  bool? enabled,
  BuildContext? context,
}) {
  return Expanded(
    child: TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context!).colorScheme.secondary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        suffixIcon: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors().border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors().border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors().border),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors().border),
        ),
        hintStyle: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintText: "Қидириш",
      ),
      onChanged: onChanged,
    ),
  );
}
