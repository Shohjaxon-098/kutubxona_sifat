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
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _retry(context),
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: 250),
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
