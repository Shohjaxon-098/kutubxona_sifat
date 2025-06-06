import 'package:kutubxona/export.dart';

class NoInternetWidget extends StatefulWidget {

  const NoInternetWidget({super.key,});

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/images/no-connect.svg'),
                Text(
                  'Нет доступа к интернету',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors().white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Проверьте подключение к интернету',
                  style: TextStyle(color: AppColors().grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
