import 'package:kutubxona/core/constants/important.dart';

class Books extends StatelessWidget {
  const Books({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 160,
            child: Card(
              color: AppColors().cardColor,
              child: const Center(child: Icon(Icons.book)),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '1984',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
        Text(
          'SIYOSAT, FANTASTIKA',
          style: TextStyle(
            color: AppColors().searchInDark,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
          children: [
            SvgPicture.asset(AppImages().rate, width: 15),
            const SizedBox(width: 8),
            Text(
              '4.7',
              style: TextStyle(
                color: AppColors().rateCount,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
