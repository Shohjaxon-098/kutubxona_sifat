import 'package:flutter/material.dart';
import 'package:kutubxona/common/navigator/app_navigator.dart';
import 'package:kutubxona/config/routes/app_routes.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/app_images.dart';
import 'package:kutubxona/features/kutubxona/presentation/widgets/phonetextfield_widget.dart';
import 'package:kutubxona/features/kutubxona/presentation/widgets/textfieldW.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  width: double.infinity,
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
                        'Ассалому алайкум\nХуш келибсиз!',
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
                SizedBox(height: 50),
                PhoneTextfieldWidget(phoneController: phoneController),
                SizedBox(height: 24),
                SizedBox(height: 6),
                textFieldW(
                  label: 'Парол',
                  controller: passwordController,
                  hint: '********',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().primaryColor,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    AppNavigator.pushNamed(context, AppRoutes.home);
                  },
                  child: Text(
                    "Кириш",
                    style: TextStyle(color: AppColors().white),
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: AppColors().primaryColor),
                    backgroundColor: AppColors().white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Телеграм орқали кириш",
                    style: TextStyle(
                      color: AppColors().primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ), // Splash yo‘q
                  ),
                  onPressed: () {
                    AppNavigator.pushNamed(context, AppRoutes.signUp);
                  },
                  child: Text(
                    "Рўйхатдан ўтиш",
                    style: TextStyle(
                      color: AppColors().primaryColor,
                      fontSize: 15,
                    ),
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
