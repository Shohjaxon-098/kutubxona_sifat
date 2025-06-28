import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';

Widget search({
  void Function(String)? onSubmitted,
  TextEditingController? controller,
  FocusNode? focusNode,
  bool? enabled,
  BuildContext? context,
}) {
  return TextField(
    controller: controller,
    focusNode: focusNode,
    enabled: enabled,
    decoration: InputDecoration(
      filled: true,
      fillColor: Theme.of(context!).colorScheme.secondary,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
      suffixIcon: Icon(
        Icons.search,
        size: 24.w,
        color: Theme.of(context).colorScheme.primary,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: AppColors().border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: AppColors().border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: AppColors().border),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: AppColors().border),
      ),
      hintStyle: TextStyle(
        fontSize: 14.sp,
        fontFamily: 'Roboto',
        color: Theme.of(context).colorScheme.primary,
      ),
      hintText: "Қидириш",
    ),
    onChanged: onSubmitted,
  );
}
