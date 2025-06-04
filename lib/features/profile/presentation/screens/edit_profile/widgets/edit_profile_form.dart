import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/auth/presentation/logic/upload_image/upload_image_bloc.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/birth_date_picker_field.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/document_image_picker.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/document_type_selector.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/gender_dropdown.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/text_input_widget.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/edit_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/edit_profile_event.dart';
import 'package:kutubxona/features/profile/presentation/screens/edit_profile/controller/edit_profile_controller.dart';
import 'package:kutubxona/features/profile/presentation/screens/edit_profile/widgets/profile_image_picker.dart';
import 'package:kutubxona/features/widgets/primary_button.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();

  void _submitForm(EditProfileController controller) {
    final profile = controller.validateAndBuildModel(_formKey);
    if (profile != null) {
      context.read<ProfileBloc>().add(UpdateProfileEvent(profile));
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<EditProfileController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Профилни ўзгартириш",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        centerTitle: true,
      ),
      body: BlocListener<UploadImageBloc, UploadImageState>(
        listener: (ctx, state) {
          if (state is UploadImageFailure) {
            ScaffoldMessenger.of(
              ctx,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileImagePicker(
                    imageFile: controller.photoFile,
                    onTap: controller.pickPhoto,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    keyboardType: TextInputType.name,
                    label: "Исмингиз",
                    controller: controller.nameController,
                    validator:
                        (v) =>
                            v == null || v.isEmpty
                                ? "Майдон тўлдирилиши шарт"
                                : null,
                  ),
                  const SizedBox(height: 16),
                  GenderDropdown(
                    selectedGender: controller.selectedGender,
                    onChanged: (g) => controller.selectedGender = g,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    keyboardType: TextInputType.visiblePassword,
                    label: "Парол",
                    controller: controller.passwordController,
                    validator:
                        (v) =>
                            v != null && v.length >= 6
                                ? null
                                : "Парол камида 6 та белгидан иборат бўлиши керак",
                    obscure: true,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    keyboardType: TextInputType.name,
                    label: "Фамилиянгиз",
                    controller: controller.surnameController,
                    validator:
                        (v) =>
                            v == null || v.isEmpty
                                ? "Майдон тўлдирилиши шарт"
                                : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    label: "Телеграм username",
                    controller: controller.telegramController,
                    validator:
                        (v) =>
                            v == null || v.isEmpty
                                ? "Майдон тўлдирилиши шарт"
                                : null,
                  ),
                  const SizedBox(height: 16),
                  BirthDatePickerField(
                    controller: controller.birthDateController,
                    onTap: () => controller.pickBirthDate(context),
                    validator:
                        (v) =>
                            v == null || v.isEmpty
                                ? "Майдон тўлдирилиши шарт"
                                : null,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Шахсий тасдиқловчи хужжат",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  DocumentTypeRadio(
                    groupValue: controller.verificationType,
                    onChanged:
                        (v) => controller.verificationType = v ?? 'passport',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    label:
                        controller.verificationType == 'passport'
                            ? "Паспорт маълумотлари *"
                            : "Гувоҳнома ID рақами *",
                    controller: controller.passportInfoController,
                    validator:
                        (v) =>
                            v == null || v.isEmpty
                                ? "Майдон тўлдирилиши шарт"
                                : null,
                  ),
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
                        onTap: () => controller.pickDocument(true),
                      ),
                      const SizedBox(width: 12),
                      ImagePickerBox(
                        file: controller.docBack,
                        onTap: () => controller.pickDocument(false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (controller.errorMessage != null)
                    Text(
                      controller.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    text: "Сақлаш",
                    onPressed: () => _submitForm(controller),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
