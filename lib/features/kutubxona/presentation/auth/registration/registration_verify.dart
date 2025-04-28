import 'package:kutubxona/core/constants/important.dart';

class RegisterVerify extends StatefulWidget {
  const RegisterVerify({super.key});

  @override
  State<RegisterVerify> createState() => _RegisterVerifyState();
}

class _RegisterVerifyState extends State<RegisterVerify> {
  // OTP uchun kerakli controllerlar va focusNode'lar
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    // Timerni ishga tushirish
    context.read<TimerBloc>().add(TimerStarted());

    // Sahifa ochilganda avtomatik ravishda birinchi inputga fokus o‘rnatish
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNodes[0]);
    });
  }

  @override
  void dispose() {
    // Controllerlar va FocusNode'larni tozalash
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
              // OTP muvaffaqiyatli o‘tganida keyingi sahifaga o‘tish
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.registerStep2Screen,
              );
            } else if (state is OtpFailure) {
              // OTP muvaffaqiyatsiz bo‘lsa, xatolikni ko‘rsatish
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
                    _buildOtpVerificationHeader(),
                    const SizedBox(height: 100),
                    _buildOtpInputFields(),
                    const SizedBox(height: 16),
                    _buildTimer(context),
                    const SizedBox(height: 150),
                    _buildPhoneChangeButton(context),
                    const SizedBox(height: 30),
                    _buildSubmitButton(context, state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // OTP tasdiqlash uchun header
  Widget _buildOtpVerificationHeader() {
    return Container(
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
    );
  }

  // Timerni ko‘rsatish va qayta yuborish tugmasi
  Widget _buildTimer(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        String count = '';
        String displayMessage = '';
        bool isButtonEnabled = false;

        if (state is TimerInitial || state is TimerRunning) {
          final timeLeft =
              (state is TimerInitial)
                  ? state.timeLeft
                  : (state as TimerRunning).timeLeft;
          count = '$timeLeft:00';
          displayMessage = count;
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

  // OTP input maydonlarini yaratish
  Widget _buildOtpInputFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return OtpWidget(
          otpController: controllers[index],
          focusNode: focusNodes[index],
          nextNode: index < 5 ? focusNodes[index + 1] : null,
          previousNode: index > 0 ? focusNodes[index - 1] : null,
          isFirst: index == 0,
          isLast: index == 5,
        );
      }),
    );
  }

  // Telefon raqamini o'zgartirish uchun tugma
  Widget _buildPhoneChangeButton(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
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
    );
  }

  // Kirish tugmasi
  Widget _buildSubmitButton(BuildContext context, OtpState state) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors().primaryColor,
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      onPressed: () async {
        final id = await AppConfig.libraryId.toString();
        final otpCode = controllers.map((c) => c.text).join();
        final phoneNumber = await AppConfig.getPhone;
        // OTP yuborish
        context.read<OtpBloc>().add(
          SubmitOtp(
            phoneNumber: phoneNumber.toString(),
            libraryId: id,
            otp: int.parse(otpCode),
          ),
        );
      },
      child:
          state is OtpLoading
              ? const CircularProgressIndicator()
              : Text(
                "Кириш",
                style: TextStyle(color: AppColors().white, fontSize: 15),
              ),
    );
  }
}
