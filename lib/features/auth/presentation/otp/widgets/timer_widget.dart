import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

class TimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        String displayMessage = '';
        bool isButtonEnabled = false;

        if (state is TimerInitial || state is TimerRunning) {
          final timeLeft =
              (state is TimerInitial) ? state.timeLeft : (state as TimerRunning).timeLeft;
          displayMessage = '$timeLeft:00';
          isButtonEnabled = timeLeft == 0;
        } else if (state is TimerCompleted) {
          displayMessage = "true";
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
                      final id = await AppConfig.libraryId.toString();
                      final phone = await AppConfig.getPhone.toString();
                      // ignore: use_build_context_synchronously
                      context.read<RegisterStep1Bloc>().add(
                        SubmitPhoneNumber(phoneNumber: phone, libraryId: id),
                      );
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
}
