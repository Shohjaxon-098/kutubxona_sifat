import 'package:kutubxona/core/util/important.dart';

Widget search({
  void Function(String)? onChanged,
  TextEditingController? controller,
  FocusNode? focusNode,
  bool? enabled,
  BuildContext? context,
}) {
  return SizedBox(
    height: 50,
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
          borderSide: BorderSide.none,
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
