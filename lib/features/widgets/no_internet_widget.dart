import 'package:kutubxona/export.dart';

class NoInternetWidget extends StatefulWidget {
  final Future<void> Function() onRetry;

  const NoInternetWidget({super.key, required this.onRetry});

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  bool isLoading = false;

  Future<void> handleRetry() async {
    setState(() => isLoading = true);
    await widget.onRetry();
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

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
                const Spacer(),
                PrimaryButton(
                  onPressed: handleRetry,
                  ttext:
                      isLoading
                          ? SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(
                              color: AppColors().cardColor,
                              strokeWidth: 2,
                            ),
                          )
                          : Text(
                            'Retry',
                            style: TextStyle(
                              color: AppColors().black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  color: AppColors().white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
