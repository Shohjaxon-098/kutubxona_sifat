import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/birth_date_picker_field.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/document_image_picker.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/document_type_selector.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/gender_dropdown.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/text_input_widget.dart';
import 'package:kutubxona/features/profile/presentation/screens/edit_profile/controller/edit_profile_controller.dart';
import 'package:kutubxona/features/profile/presentation/screens/edit_profile/widgets/profile_image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late EditProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = EditProfileController(context: context);
  }

  @override
  void dispose() {
    controller.disposeController();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text("Профильни таҳрирлаш"),
        centerTitle: true,
      ),
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
                    ProfileImagePicker(
                      // file: controller.photoFile,
                      // onTap: () => controller.pickPhoto(),
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
                      onChanged: controller.setGender,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: "Парол",
                      controller: controller.passwordController,
                      keyboardType: TextInputType.text,
                      validator: validatePassword,
                      obscure: true,
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
                      onTap: controller.pickBirthDate,
                      validator: validateRequired,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Шахсий тасдиқловчи хужжат",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    DocumentTypeRadio(
                      groupValue: controller.verificationType,
                      onChanged: controller.setVerificationType,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label:
                          controller.verificationType == 'passport'
                              ? "Паспорт маълумотлари *"
                              : "Гувоҳнома ID рақами *",
                      controller: controller.passportInfoController,
                      keyboardType: TextInputType.text,
                      validator: validateRequired,
                    ),
                    if (controller.verificationType == 'passport') ...[
                      const SizedBox(height: 16),
                      const Text(
                        "Ҳужжат расмини юкланг",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ImagePickerBox(
                            file:
                                controller
                                    .photoFile, // oldindan fayl bo‘lsa ko‘rsatadi
                            onTap: () => controller.pickImage(true),
                          ),
                          const SizedBox(width: 12),
                          ImagePickerBox(
                            file: controller.photoFile,
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
                    PrimaryButton(text: "Сақлаш", onPressed: () {}),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
