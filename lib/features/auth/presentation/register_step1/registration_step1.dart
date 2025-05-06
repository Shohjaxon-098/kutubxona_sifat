import 'package:kutubxona/export.dart';

class RegisterStep1Screen extends StatelessWidget {
  const RegisterStep1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: RegisterStep1Form(),
    );
  }
}

class RegisterStep1Form extends StatefulWidget {
  const RegisterStep1Form({super.key});

  @override
  State<RegisterStep1Form> createState() => _RegisterStep1FormState();
}

class _RegisterStep1FormState extends State<RegisterStep1Form> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: 50),
              PhoneTextfieldWidget(phoneController: phoneController),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.31),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors().primaryColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () async {
  final phone = phoneController.text.replaceAll(' ', '').trim();

            await LocalStorage.savePhone(phone);
            final id = await AppConfig.libraryId.toString();
            // ignore: use_build_context_synchronously
            context.read<RegisterStep1Bloc>().add(
              SubmitPhoneNumber(phoneNumber: phone, libraryId: id),
            );
            AppNavigator.pushNamed(context, AppRoutes.registerVerify);
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
            // ignore: deprecated_member_use
            overlayColor: MaterialStateProperty.all(Colors.transparent),
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
    );
  }
}
