import 'package:kutubxona/export.dart';

class HeaderCardWidget extends StatelessWidget {
  const HeaderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(AppImages().mask),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            const SizedBox(height: 33),
            _buildHeaderText(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        color: AppColors().white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            blurRadius: 0,
            spreadRadius: 5,
            color: AppColors().cardShadow,
          ),
        ],
        image: DecorationImage(
          image: AssetImage(AppImages().logo),
          scale: 11,
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Text(
      'Қайси худуддаги кутубхоналардан фойдаланмоқчисиз?',
      style: TextStyle(
        color: AppColors().white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }
}
