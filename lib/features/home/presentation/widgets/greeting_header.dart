import 'package:kutubxona/export.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages().mask),
          fit: BoxFit.cover,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Ассалому алайкум!\nShohjaxon',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors().white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: AppColors().white,
              radius: 28,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: SvgPicture.asset(AppImages().person, width: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
