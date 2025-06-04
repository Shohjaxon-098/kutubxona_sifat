import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/auth/presentation/logic/upload_image/upload_image_bloc.dart';
import 'package:kutubxona/features/profile/data/model/edit_profile_model.dart';

class EditProfileController extends ChangeNotifier {
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

  String? errorMessage;
  final BuildContext context;
  EditProfileController({required this.context}) {
    _listenUploadImageBloc();
  }
  void _listenUploadImageBloc() {
    final uploadImageBloc = context.read<UploadImageBloc>();
    uploadImageBloc.stream.listen((state) {
      if (state is UploadImageSuccess) {
        if (state.isFront) {
          docFrontId = state.id;
        } else {
          docBackId = state.id;
        }
        notifyListeners();
      } else if (state is UploadImageFailure) {
        errorMessage = state.message;
        notifyListeners();
      }
    });
  }

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

  Future<File?> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    return picked != null ? File(picked.path) : null;
  }

  Future<void> pickPhoto() async {
    final file = await _pickImage();
    if (file != null) {
      photoFile = file;
      photoId = 123; // TODO: replace with actual upload logic
      notifyListeners();
    }
  }

  Future<void> pickDocument(bool isFront) async {
    final file = await _pickImage();
    if (file != null) {
      if (isFront) {
        docFront = file;
      } else {
        docBack = file;
      }
      notifyListeners();
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
      notifyListeners();
    }
  }

  UpdateProfileModel? validateAndBuildModel(GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) return null;

    if (photoFile == null) {
      errorMessage = "Фото расмини юкланг";
      notifyListeners();
      return null;
    }
    if (docFront == null || docBack == null) {
      errorMessage = "Ҳужжат расмини икки тарафини ҳам юкланг";
      notifyListeners();
      return null;
    }

    errorMessage = null;
    notifyListeners();

    return UpdateProfileModel(
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
    );
  }
}
