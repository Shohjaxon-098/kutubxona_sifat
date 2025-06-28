import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:kutubxona/export.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  Future<void> _retry(BuildContext context) async {
    final connected = await InternetConnection().hasInternetAccess;
    if (connected) {
      AppNavigator.pushReplacementNamed(context, AppRoutes.splash);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: RefreshIndicator(
          onRefresh: () => _retry(context),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/no-connect.svg',
                        height: 180.h,
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Нет доступа к интернету',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Проверьте подключение к интернету',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors().grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
