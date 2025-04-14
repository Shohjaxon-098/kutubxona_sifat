import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step1.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_verify.dart';
import 'package:kutubxona/service/apis/api_service.dart';
import 'package:kutubxona/service/hive_service.dart';
import 'package:kutubxona/service/library_id.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  @override
  void initState() {
    super.initState();

    context.read<TimerBloc>().add(TimerStarted());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          String count = '';
          String displayMessage = '';
          bool isButtonEnabled = false;
          if (state is TimerInitial || state is TimerRunning) {
            final timeLeft =
                (state is TimerInitial)
                    ? state.timeLeft
                    : (state as TimerRunning).timeLeft;
            if (timeLeft > 0) {
              count = '$timeLeft:00';
              displayMessage = count;
              isButtonEnabled = false;
            } else if (timeLeft == 0) {
              count = '$timeLeft:00';
              displayMessage = count;
              isButtonEnabled = true;
            }
          } else if (state is TimerCompleted) {
            displayMessage = "true";
            isButtonEnabled = true;
          }
          return SafeArea(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(AppImages().secure),
                            ),
                          ),
                          const SizedBox(height: 33),
                          Text(
                            'Телефонингизга юборилган\nкодни киритинг',
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
                    const SizedBox(height: 100),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (index) {
                            return OtpWidget(
                              otpController: controllers[index],
                              focusNode: focusNodes[index],
                              nextNode:
                                  index < 5 ? focusNodes[index + 1] : null,
                              previousNode:
                                  index > 0 ? focusNodes[index - 1] : null,
                            );
                          }),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          textAlign: TextAlign.center,
                          displayMessage,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        isButtonEnabled
                            ? TextButton(
                              style: ButtonStyle(
                                overlayColor: WidgetStateProperty.all(
                                  Colors.transparent,
                                ), // Splash yo‘q
                              ),
                              onPressed: () {
                                context.read<TimerBloc>().add(TimerStarted());
                              },
                              child: Text(
                                "Қайта юбориш",
                                style: TextStyle(
                                  color: AppColors().blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                            : const SizedBox(height: 48),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ), // Splash yo‘q
                      ),
                      child: Text(
                        'Телефон рақамни ўзгартириш',
                        style: TextStyle(
                          color: AppColors().blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors().primaryColor,
                        minimumSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () async {
                        String? libPhone = await LocalStorage.getPhone();
                        RegisterVerify registerVerify = RegisterVerify(
                          otpCode: controllers.toString(),
                          phone: libPhone!,
                          libraryId: libraryId,
                        );
                        print(libPhone);
                        try {
                          ApiService apiService = ApiService();
                          var response = await apiService.registerVerify(
                            registerVerify,
                          ); // <- faqat model yuboriladi
                          if (response.statusCode == 201) {
                            // Save user data to local storage (Hive)

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('User Registered Successfully'),
                              ),
                            );
                            AppNavigator.pushNamed(
                              context,
                              AppRoutes.otpScreen,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registration Failed'),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      },
                      child: Text(
                        "Кириш",
                        style: TextStyle(
                          color: AppColors().white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
