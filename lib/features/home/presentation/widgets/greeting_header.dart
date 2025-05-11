
import 'package:kutubxona/export.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        image: DecorationImage(
          image: AssetImage(AppImages().mask),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ассалому алайкум!\n',
            style: TextStyle(
              fontSize: 20,
              color: AppColors().white,
              fontWeight: FontWeight.w500,
            ),
          ),
          CircleAvatar(
            backgroundColor: AppColors().white,
            radius: 28,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: SvgPicture.asset(
                AppImages().person,
                width: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
