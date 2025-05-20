import 'package:kutubxona/export.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppImages().splashLogo, width: 140, height: 140);
  }
}
