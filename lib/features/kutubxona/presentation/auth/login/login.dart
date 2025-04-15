import 'package:flutter/material.dart';
import 'package:kutubxona/common/navigator/app_navigator.dart';
import 'package:kutubxona/config/routes/app_routes.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/app_images.dart';
import 'package:kutubxona/features/kutubxona/presentation/widgets/phonetextfield_widget.dart';
import 'package:kutubxona/features/kutubxona/presentation/widgets/textfieldW.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
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
                      const SizedBox(height: 33),
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
                const SizedBox(height: 50),
                PhoneTextfieldWidget(phoneController: phoneController),
                const SizedBox(height: 24),

                textFieldW(
                  context: context,
                  label: 'Парол',
                  controller: passwordController,
                  hint: '********',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().primaryColor,
                    minimumSize: const Size(double.infinity, 50),
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
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: AppColors().primaryColor),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    minimumSize: const Size(double.infinity, 50),
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
                const SizedBox(height: 12),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ), // Splash yo‘q
                  ),
                  onPressed: () {
                    AppNavigator.pushNamed(
                      context,
                      AppRoutes.registerStep1Screen,
                    );
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
