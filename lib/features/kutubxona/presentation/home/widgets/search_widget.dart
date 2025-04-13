import 'package:kutubxona/core/util/important.dart';

Widget search({
  void Function(String)? onChanged,
  TextEditingController? controller,
  FocusNode? focusNode,
  bool? enabled,
}) {
  return SizedBox(
    height: 50,
    child: TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      style: TextStyle(color: AppColors().black),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors().searchBack,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        suffixIcon: Icon(Icons.search, color: AppColors().searchIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(fontSize: 14, color: AppColors().searchIcon),
        hintText: "Қидириш",
      ),
      onChanged: onChanged,
    ),
  );
}
