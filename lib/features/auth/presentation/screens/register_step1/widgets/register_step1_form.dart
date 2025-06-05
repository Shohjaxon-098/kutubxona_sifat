import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step1/controller/register_step1_controller.dart';

class RegisterStep1Form extends StatefulWidget {
  const RegisterStep1Form({super.key});

  @override
  State<RegisterStep1Form> createState() => _RegisterStep1FormState();
}

class _RegisterStep1FormState extends State<RegisterStep1Form> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterStep1Controller>();

    return Form(
      key: controller.formKey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocListener<RegisterStep1Bloc, RegisterStep1State>(
            listener:
                (context, state) => controller.handleState(state, context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 50),
                PhoneTextfieldWidget(
                  phoneController: controller.phoneController,
                ),
                Spacer(),
                _buildButtons(context, controller),
              ],
            ),
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
                image: AssetImage(AppImages().logo),
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

  Widget _buildButtons(
    BuildContext context,
    RegisterStep1Controller controller,
  ) {
    return Column(
      children: [
        PrimaryButton(
          onPressed:
              controller.isLoading
                  ? null
                  : () => controller.submitPhoneNumber(context),
          child:
              controller.isLoading
                  ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                  : Text(
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
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () => controller.goToLogin(context),
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
