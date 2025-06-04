import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/controller/register_step2_controller.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/document_image_picker.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/document_type_selector.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/text_input_widget.dart';
import 'widgets/gender_dropdown.dart';
import 'widgets/birth_date_picker_field.dart';

class RegisterStep2Screen extends StatefulWidget {
  const RegisterStep2Screen({super.key});

  @override
  State<RegisterStep2Screen> createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  final _formKey = GlobalKey<FormState>();
  late RegisterStep2Controller controller;
  bool _obscureText = true;

  void toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = RegisterStep2Controller(context: context);
  }

  @override
  void dispose() {
    controller.disposeController();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterStep2Bloc, RegisterStep2State>(
          listener: (ctx, state) {
            if (state is RegisterStep2Failure) {
              ScaffoldMessenger.of(
                ctx,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is RegisterStep2Success) {
              Navigator.pushNamed(ctx, AppRoutes.home);
            }
          },
        ),
        BlocListener<UploadImageBloc, UploadImageState>(
          listener: (ctx, state) {
            if (state is UploadImageFailure) {
              ScaffoldMessenger.of(
                ctx,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Рўйхатдан ўтиш',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        label: "Исмингиз",
                        controller: controller.nameController,
                        keyboardType: TextInputType.name,
                        validator: validateRequired,
                      ),
                      const SizedBox(height: 16),
                      GenderDropdown(
                        selectedGender: controller.selectedGender,
                        onChanged: (val) => controller.setGender(val),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: "Парол",
                        controller: controller.passwordController,
                        keyboardType: TextInputType.text,
                        validator: validatePassword,
                        obscure: _obscureText,
                        suffixIcon: GestureDetector(
                          onTap: toggleVisibility,
                          child: SvgPicture.asset(
                            fit: BoxFit.scaleDown,
                            _obscureText
                                ? 'assets/icons/eye-hide.svg'
                                : 'assets/icons/eye-show.svg',

                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: "Фамилиянгиз",
                        controller: controller.surnameController,
                        keyboardType: TextInputType.name,
                        validator: validateRequired,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: "Телеграм username",
                        controller: controller.telegramController,
                        keyboardType: TextInputType.text,
                        validator: validateRequired,
                      ),
                      const SizedBox(height: 16),
                      BirthDatePickerField(
                        controller: controller.birthDateController,
                        onTap: () => controller.pickBirthDate(),
                        validator: validateRequired,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Шахсий тасдиқловчи хужжат",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      DocumentTypeRadio(
                        groupValue: controller.documentType,
                        onChanged: (val) => controller.setDocumentType(val),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label:
                            controller.documentType == 'passport'
                                ? "Паспорт маълумотлари *"
                                : "Гувоҳнома ID рақами *",
                        controller: controller.passportInfoController,
                        keyboardType: TextInputType.text,
                        validator: validateRequired,
                      ),
                      if (controller.documentType == 'passport') ...[
                        const SizedBox(height: 16),
                        const Text(
                          "Ҳужжат расмини юкланг",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ImagePickerBox(
                              file: controller.docFront,
                              onTap: () => controller.pickImage(true),
                            ),
                            const SizedBox(width: 12),
                            ImagePickerBox(
                              file: controller.docBack,
                              onTap: () => controller.pickImage(false),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 24),
                      if (controller.apiErrorMessage != null)
                        Text(
                          controller.apiErrorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 12),
                      PrimaryButton(
                        text: "Кириш",
                        onPressed: () => controller.submitForm(_formKey),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
