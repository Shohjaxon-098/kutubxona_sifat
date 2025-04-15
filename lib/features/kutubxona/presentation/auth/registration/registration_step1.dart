import 'package:flutter/material.dart';
import 'package:kutubxona/common/navigator/app_navigator.dart';
import 'package:kutubxona/config/routes/app_routes.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/app_images.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step1.dart';
import 'package:kutubxona/features/kutubxona/presentation/widgets/phonetextfield_widget.dart';
import 'package:kutubxona/service/api_service.dart';

import 'package:kutubxona/service/hive_service.dart';
import 'package:kutubxona/service/library_id.dart';
import 'package:kutubxona/service/open_dio_client.dart';

class RegisterStep1Screen extends StatefulWidget {
  const RegisterStep1Screen({super.key});

  @override
  State<RegisterStep1Screen> createState() => _RegisterStep1ScreenState();
}

class _RegisterStep1ScreenState extends State<RegisterStep1Screen> {
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
                      const SizedBox(height: 30),
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
                Text(ApiClient().errorData),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.31),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    RegisterStep1 registerStep1 = RegisterStep1(
                      phone: phoneController.text,
                      libraryId: libraryId,
                    );
                    try {
                      ApiService apiService = ApiService();
                      var response = await apiService.registerStep1(
                        registerStep1,
                      ); // <- faqat model yuboriladi
                      if (response.statusCode == 201) {
                        // Save user data to local storage (Hive)
                        await LocalStorage.savePhone(phoneController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User Registered Successfully'),
                          ),
                        );
                        AppNavigator.pushNamed(
                          context,
                          AppRoutes.registerVerify,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registration Failed')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  },
                  child: Text(
                    "Давом этиш",
                    style: TextStyle(
                      color: AppColors().white,
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
                    AppNavigator.pop(context);
                  },
                  child: Text(
                    "Кириш",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
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
