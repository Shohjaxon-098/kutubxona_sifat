import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/auth/presentation/screens/otp/widgets/otp_input_fields.dart';
import 'package:kutubxona/features/auth/presentation/screens/otp/widgets/otp_verification_header.dart';
import 'package:kutubxona/features/auth/presentation/screens/otp/widgets/phone_change_button.dart';
import 'package:kutubxona/features/auth/presentation/screens/otp/widgets/submit_button.dart';
import 'package:kutubxona/features/auth/presentation/screens/otp/widgets/timer_widget.dart';

class RegisterVerifyPage extends StatefulWidget {
  const RegisterVerifyPage({super.key});

  @override
  State<RegisterVerifyPage> createState() => _RegisterVerifyPageState();
}

class _RegisterVerifyPageState extends State<RegisterVerifyPage> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    context.read<TimerBloc>().add(TimerStarted());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNodes[0]);
    });
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocConsumer<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state is OtpSuccess) {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.registerStep2Screen,
              );
            } else if (state is OtpFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OtpVerificationHeader(),
                    const SizedBox(height: 100),
                    OtpInputFields(
                      controllers: controllers,
                      focusNodes: focusNodes,
                    ),
                    const SizedBox(height: 16),
                    TimerWidget(),
                    const SizedBox(height: 48),
                    PhoneChangeButton(),
                    const SizedBox(height: 48),
                    SubmitButton(controllers: controllers, state: state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
