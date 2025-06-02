import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/profile/domain/entities/edit_profile_entity.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/bloc/profile_event.dart';

class EditProfileController extends ChangeNotifier {
  final BuildContext context;

  // Text controllers
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final telegramController = TextEditingController();
  final birthDateController = TextEditingController();
  final passportInfoController = TextEditingController();
  final passwordController = TextEditingController();

  // Form field values
  String? selectedGender;
  String? verificationType;
  String? documentType = 'passport';

  // Media files
  File? photoFile;
  File? docFront;
  File? docBack;

  // Uploaded file IDs
  int? photoId;
  int? docFrontId;
  int? docBackId;

  // API error handling
  String? apiErrorMessage;

  EditProfileController({required this.context}) {
    _listenUploadImageBloc();
  }

  void _listenUploadImageBloc() {
    context.read<UploadImageBloc>().stream.listen((state) {
      if (state is UploadImageSuccess) {
        if (state.isFront) {
          docFrontId = state.id;
        } else if (state.isFront == false && docBackId == null) {
          docBackId = state.id;
        } else {
          photoId = state.id;
        }
        notifyListeners();
      } else if (state is UploadImageFailure) {
        apiErrorMessage = state.message;
        notifyListeners();
      }
    });
  }

  Future<void> pickPhoto() async {
    final picked = await pickImageFromGallery();
    if (picked != null) {
      final file = File(picked.path);
      photoFile = file;
      notifyListeners();
    }
  }

  Future<void> pickImage(bool isFront) async {
    final picked = await pickImageFromCamera();
    if (picked != null) {
      final file = File(picked.path);
      if (isFront) {
        docFront = file;
        context.read<UploadImageBloc>().add(
          StartUploadImage(file, isFront: true),
        );
      } else {
        docBack = file;
        context.read<UploadImageBloc>().add(
          StartUploadImage(file, isFront: false),
        );
      }
      notifyListeners();
    }
  }

  Future<void> pickBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      birthDateController.text =
          "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      notifyListeners();
    }
  }

  void setGender(String? value) {
    selectedGender = value;
    notifyListeners();
  }

  void setVerificationType(String? value) {
    verificationType = value;
    notifyListeners();
  }

  void setDocumentType(String? value) {
    documentType = value;
    docFront = null;
    docBack = null;
    notifyListeners();
  }

  Future<void> submitForm(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    if (documentType == 'passport' &&
        (docFrontId == null || docBackId == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ҳужжат файлларини юкланг!")),
      );
      return;
    }

    final entity = EditProfileEntity(
      firstName: nameController.text,
      lastName: surnameController.text,
      gender: selectedGender!,
      telegramUsername: telegramController.text,
      password: passwordController.text,
      birthDate: birthDateController.text,
      documentNumber: passportInfoController.text,
      documentFile1: docFrontId,
      documentFile2: docBackId,
      photo: photoId,
      verificationType: verificationType,
    );
    final libraryId = AppConfig.libraryId.toString();
    context.read<ProfileBloc>().add(UpdateProfileEvent(libraryId, entity));
  }

  void disposeController() {
    nameController.dispose();
    surnameController.dispose();
    telegramController.dispose();
    birthDateController.dispose();
    passportInfoController.dispose();
    passwordController.dispose();
  }
}
