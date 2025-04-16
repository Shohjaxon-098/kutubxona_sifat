import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step1.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/register_step1_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/register_step1_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/register_step1_state.dart';
import 'package:kutubxona/features/kutubxona/presentation/widgets/phonetextfield_widget.dart';
import 'package:kutubxona/service/library_id.dart';

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
          child: BlocBuilder<RegisterStep1Bloc, RegisterStep1State>(
            builder: (context, state) {
              String? errorMessage;
              bool isLoading = false;

              if (state is RegisterStep1Error) {
                errorMessage = state.message;
              } else if (state is RegisterStep1Loading) {
                isLoading = true;
              }

              return Padding(
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
                    if (errorMessage != null)
                      Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.31),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors().primaryColor,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        RegisterStep1 registerStep1 = RegisterStep1(
                          phone: phoneController.text,
                          libraryId: libraryId,
                        );
                        context.read<RegisterStep1Bloc>().add(
                          RegisterStep1Submitted(registerStep1),
                        );
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
              );
            },
          ),
        ),
      ),
    );
  }
}
