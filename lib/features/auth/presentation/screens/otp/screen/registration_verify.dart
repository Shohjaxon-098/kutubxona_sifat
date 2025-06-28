import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/auth/presentation/screens/otp/widgets/otp_pinput_widget.dart';
import 'package:kutubxona/features/auth/presentation/screens/otp/widgets/otp_verification_header.dart';
import 'package:kutubxona/features/auth/presentation/screens/otp/widgets/phone_change_button.dart';
import 'package:kutubxona/features/auth/presentation/screens/otp/widgets/submit_button.dart';
import 'package:kutubxona/features/auth/presentation/screens/otp/widgets/timer_widget.dart';
import 'package:sms_autofill/sms_autofill.dart';

class RegisterVerifyPage extends StatefulWidget {
  const RegisterVerifyPage({super.key});

  @override
  State<RegisterVerifyPage> createState() => _RegisterVerifyPageState();
}

class _RegisterVerifyPageState extends State<RegisterVerifyPage>
    with CodeAutoFill {
  final TextEditingController _pinController = TextEditingController();
  late final FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    listenForCode();
    focusNode = FocusNode();
    context.read<TimerBloc>().add(TimerStarted());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    focusNode.dispose();
    cancel();
    super.dispose();
  }

  @override
  void codeUpdated() {
    setState(() {
      _pinController.text = code!;
    });
  }

  void _submitOtp() {
    final otp = _pinController.text.trim();

    if (otp.length < 6 || otp.contains(RegExp(r'\D'))) {
      ToastMessage.showToast("Кодни тўлиқ ва тўғри киритинг", context);
      return;
    }

    final id = AppConfig.libraryId.toString();
    final phoneNumber = AppConfig.getPhone.toString();

    context.read<OtpBloc>().add(
      SubmitOtp(phoneNumber: phoneNumber, libraryId: id, otp: int.parse(otp)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocConsumer<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state is OtpSuccess) {
              AppNavigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.registerStep2Screen,
              );
            } else if (state is OtpFailure) {
              ToastMessage.showToast(state.message, context);
            }
          },
          builder: (context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics:
                      constraints.maxHeight > 600.h
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          children: [
                            OtpVerificationHeader(),
                            SizedBox(height: 50.h),
                            OtpPinput(
                              controller: _pinController,
                              focusNode: focusNode,
                              onCompleted: (_) => _submitOtp(),
                            ),
                            SizedBox(height: 16.h),
                            const TimerWidget(),
                            const Spacer(),
                            PhoneChangeButton(),
                            SizedBox(height: 24.h),
                            SubmitButton(
                              controller: _pinController,
                              state: state,
                              onPressed: _submitOtp,
                            ),
                            SizedBox(height: 12.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
