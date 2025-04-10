import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/common/navigator/app_navigator.dart';
import 'package:kutubxona/config/routes/app_routes.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/app_images.dart';
import 'package:kutubxona/features/kutubxona/presentation/bloc/bloc_timer/timer_count_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/bloc/bloc_timer/timer_count_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/bloc/bloc_timer/timer_count_state.dart';
import 'package:kutubxona/features/kutubxona/presentation/widgets/otp_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
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
              physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        padding: const EdgeInsets.only(left: 30, right: 30),
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
                                image: DecorationImage(
                                  image: AssetImage(AppImages().privacy),
                                ),
                              ),
                            ),
                            SizedBox(height: 33),
                            Text(
                              'Телефонингизга юборилган кодни киритинг',
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
                    SizedBox(height: 100),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return OtpWidget(
                              color: AppColors().black,
                              otpController: controllers[index],
                              focusNode: focusNodes[index],
                              nextNode:
                                  index < 3 ? focusNodes[index + 1] : null,
                              previousNode:
                                  index > 0 ? focusNodes[index - 1] : null,
                            );
                          }),
                        ),
                        SizedBox(height: 12),
                        Text(
                          textAlign: TextAlign.center,
                          displayMessage,
                          style: TextStyle(
                            color: AppColors().black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        isButtonEnabled
                            ? TextButton(
                              onPressed: () {
                                context.read<TimerBloc>().add(TimerStarted());
                              },
                              child: Text(
                                "Қайта юбориш",
                                style: TextStyle(
                                  color: AppColors().blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                            : SizedBox(height: 48),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    TextButton(
                      child: Text(
                        'Телефон рақамни ўзгартириш',
                        style: TextStyle(
                          color: AppColors().blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),

                    SizedBox(height: 30),

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
                        AppNavigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.home,
                        );
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
          );
        },
      ),
    );
  }
}
