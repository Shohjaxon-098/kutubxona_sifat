import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/export.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        String displayMessage = '';
        bool isButtonEnabled = false;

        if (state is TimerInitial) {
          displayMessage = _formatTime(state.timeLeft);
          isButtonEnabled = state.timeLeft == 0;
        } else if (state is TimerRunning) {
          displayMessage = _formatTime(state.timeLeft);
          isButtonEnabled = state.timeLeft == 0;
        } else if (state is TimerCompleted) {
          displayMessage = "00:00";
          isButtonEnabled = true;
        }

        return Column(
          children: [
            Text(
              displayMessage,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            isButtonEnabled
                ? TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () async {
                    final id = AppConfig.libraryId.toString();
                    final phone = await AppConfig.getPhone.toString();

                    // Qayta telefon raqamini yuborish eventi
                    context.read<RegisterStep1Bloc>().add(
                      SubmitPhoneNumber(phoneNumber: phone, libraryId: id),
                    );

                    // Timerni 60 sekundga qayta ishga tushurish
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
        );
      },
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}
