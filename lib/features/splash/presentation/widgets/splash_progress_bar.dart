import 'package:kutubxona/export.dart';

class SplashProgressBar extends StatelessWidget {
  final AnimationController controller;

  const SplashProgressBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return LinearProgressIndicator(
            value: controller.value,
            backgroundColor: AppColors().linerBackgroundColor,
            valueColor: AlwaysStoppedAnimation(AppColors().linerValueColor),
            borderRadius: BorderRadius.circular(5),
          );
        },
      ),
    );
  }
}
