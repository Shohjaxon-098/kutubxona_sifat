import 'package:flutter/material.dart';
import 'package:kutubxona/common/navigator/app_navigator.dart';
import 'package:kutubxona/config/routes/app_routes.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/app_images.dart';
import 'package:kutubxona/features/kutubxona/presentation/widgets/textfield_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 260,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors().grey,
                        spreadRadius: 2,
                        blurRadius: 60,
                        offset: Offset(5, 12),
                      ),
                    ],
                    color: AppColors().cardColor,
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: AssetImage(AppImages().mask),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 38,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
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
                              image: AssetImage(AppImages().splashLogo),
                              scale: 11,
                            ),
                          ),
                        ),
                        SizedBox(height: 33),
                        Text(
                          'Ассалому алайкум  Хуш келибсиз!',
                          style: TextStyle(
                            color: AppColors().white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
                TextfieldWidget(phoneController: phoneController),
                SizedBox(height: MediaQuery.of(context).size.height * 0.4),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    backgroundColor: AppColors().onBoardbuttonColor,
                    minimumSize: Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    AppNavigator.pushNamed(context, AppRoutes.otpScreen);
                  },
                  child: Text(
                    "Кириш",
                    style: TextStyle(color: AppColors().white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
