import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/util/app_images.dart';
import 'package:kutubxona/features/kutubxona/presentation/bloc/bloc_timer/timer_count_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/bloc/bloc_timer/timer_count_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/bloc/bloc_timer/timer_count_state.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/home/home_screen.dart';
import 'package:kutubxona/features/kutubxona/presentation/widgets/otp_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();
  @override
  void initState() {
    super.initState();

    context.read<TimerBloc>().add(
      TimerStarted(),
    ); // Ekran ochilganda timerStarted chaqiramiz
  }

  @override
  Widget build(BuildContext context) {
    List otpController = [
      otpController1,
      otpController2,
      otpController3,
      otpController4,
      otpController5,
      otpController6,
    ];
    return Scaffold(
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
            } else {
              displayMessage = "Қайта юбориш";
              isButtonEnabled = true;
            }
          } else if (state is TimerCompleted) {
            displayMessage = "true";
            isButtonEnabled = true;
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 290,
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
                      padding: const EdgeInsets.symmetric(horizontal: 30),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return OtpWidget(
                        color: AppColors().black,
                        otpController: otpController[index],
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      );
                    }),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    displayMessage,
                    style: TextStyle(
                      color: AppColors().blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  Spacer(),
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
                  SizedBox(height: 31),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        backgroundColor: AppColors().onBoardbuttonColor,
                        minimumSize: Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                      child: Text(
                        "Кириш",
                        style: TextStyle(color: AppColors().white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
