import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/birth_date_picker_field.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/document_image_picker.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/document_type_selector.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/gender_dropdown.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step2/widgets/text_input_widget.dart';
import 'package:kutubxona/features/profile/data/model/edit_profile_model.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/edit_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/edit_profile_event.dart';
import 'package:kutubxona/features/profile/presentation/screens/edit_profile/widgets/profile_image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();
  final telegramController = TextEditingController();
  final birthDateController = TextEditingController();
  final passportInfoController = TextEditingController();

  String? selectedGender;
  String verificationType = 'passport';

  File? photoFile;
  File? docFront;
  File? docBack;

  int? photoId;
  int? docFrontId;
  int? docBackId;

  String? apiErrorMessage;

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    passwordController.dispose();
    telegramController.dispose();
    birthDateController.dispose();
    passportInfoController.dispose();
    super.dispose();
  }

  Future<File?> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    return picked != null ? File(picked.path) : null;
  }

  void pickPhoto() async {
    final file = await pickImage();
    if (file != null) {
      setState(() {
        photoFile = file;
        photoId = 123; // TODO: Replace with actual upload logic
      });
    }
  }

  void pickDocument(bool isFront) async {
    final file = await pickImage();
    if (file != null) {
      setState(() {
        if (isFront) {
          docFront = file;
        } else {
          docBack = file;
        }
      });
    }
  }

  void pickBirthDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      birthDateController.text = picked.toIso8601String().split('T').first;
    }
  }

  void submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (photoFile == null) {
      setState(() => apiErrorMessage = "Фото расмини юкланг");
      return;
    }
    if (docFront == null || docBack == null) {
      setState(
        () => apiErrorMessage = "Ҳужжат расмини икки тарафини ҳам юкланг",
      );
      return;
    }

    final profile = UpdateProfileModel(
      firstName: nameController.text,
      lastName: surnameController.text,
      password: passwordController.text,
      telegramUsername: telegramController.text,
      birthDate: birthDateController.text,
      gender: selectedGender ?? 'unknown',
      verificationType: verificationType,
      documentNumber: passportInfoController.text,
      documentFile1: docFrontId,
      documentFile2: docBackId,
      photo: photoId,
      documentFile1Path: docFront?.path,
      documentFile2Path: docBack?.path,
      photoPath: photoFile?.path,
    );

    context.read<ProfileBloc>().add(UpdateProfileEvent(profile));

    setState(() => apiErrorMessage = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профилни ўзгартириш"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileImagePicker(imageFile: photoFile, onTap: pickPhoto),
                const SizedBox(height: 24),
                CustomTextField(
                  keyboardType: TextInputType.name,
                  label: "Исмингиз",
                  controller: nameController,
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? "Майдон тўлдирилиши шарт"
                              : null,
                ),
                const SizedBox(height: 16),
                GenderDropdown(
                  selectedGender: selectedGender,
                  onChanged: (g) => setState(() => selectedGender = g),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  keyboardType: TextInputType.visiblePassword,
                  label: "Парол",
                  controller: passwordController,
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
                  controller: surnameController,
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
                  controller: telegramController,
                  validator:
                      (v) =>
                          v == null || v.isEmpty
                              ? "Майдон тўлдирилиши шарт"
                              : null,
                ),
                const SizedBox(height: 16),
                BirthDatePickerField(
                  controller: birthDateController,
                  onTap: () => pickBirthDate(context),
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
                  groupValue: verificationType,
                  onChanged:
                      (type) =>
                          setState(() => verificationType = type ?? 'passport'),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  label:
                      verificationType == 'passport'
                          ? "Паспорт маълумотлари *"
                          : "Гувоҳнома ID рақами *",
                  controller: passportInfoController,
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
                      file: docFront,
                      onTap: () => pickDocument(true),
                    ),
                    const SizedBox(width: 12),
                    ImagePickerBox(
                      file: docBack,
                      onTap: () => pickDocument(false),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (apiErrorMessage != null)
                  Text(
                    apiErrorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 12),
                PrimaryButton(text: "Сақлаш", onPressed: submitForm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
