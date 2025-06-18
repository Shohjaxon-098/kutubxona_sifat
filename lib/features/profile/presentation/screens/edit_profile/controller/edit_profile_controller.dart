import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/auth/presentation/logic/upload_image/upload_image_bloc.dart';
import 'package:kutubxona/features/profile/data/model/edit_profile_model.dart';
import 'package:kutubxona/features/profile/domain/entities/edit_profile_entity.dart';
import 'package:kutubxona/features/profile/domain/entities/user_entity.dart';

class EditProfileController extends ChangeNotifier {
  final BuildContext context;

  // Text controllers
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();
  final telegramController = TextEditingController();
  final birthDateController = TextEditingController();
  final passportInfoController = TextEditingController();

  // Gender (reactive)
  String? _selectedGender;
  String? get selectedGender => _selectedGender;
  set selectedGender(String? value) {
    _selectedGender = value;
    notifyListeners();
  }

  // Verification type
  String _verificationType = 'passport';
  String get verificationType => _verificationType;
  set verificationType(String value) {
    _verificationType = value;
    notifyListeners();
  }

  // Local files
  File? photoFile;
  File? docFront;
  File? docBack;

  // Image URLs (initial from server)
  String? photoUrl;
  String? docFrontUrl;
  String? docBackUrl;

  // Uploaded image IDs
  int? photoId;
  int? docFrontId;
  int? docBackId;

  // Error
  String? errorMessage;

  late final StreamSubscription _subscription;

  EditProfileController({required this.context}) {
    _listenUploadImageBloc();
  }

  void _listenUploadImageBloc() {
    final uploadImageBloc = context.read<UploadImageBloc>();
    _subscription = uploadImageBloc.stream.listen((state) {
      if (state is UploadImageSuccess) {
        if (state.type == 'photo') {
          photoId = state.id;
        } else if (state.isFront == true) {
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

  /// Set initial values from profile
  void setInitialValues(UserProfileEntity profile) {
    nameController.text = profile.firstName;
    surnameController.text = profile.lastName;
    telegramController.text = profile.telegramUsername;
    passwordController.text = "*******";
    birthDateController.text = profile.birthDate;
    _selectedGender = profile.gender;
    _verificationType = profile.verificationType;
    passportInfoController.text = profile.documentNumber;

    photoUrl = profile.photoPath;
    docFrontUrl = profile.documentFile1Path;
    docBackUrl = profile.documentFile2Path;

    notifyListeners();
  }

  /// Pick image from gallery
  Future<File?> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    return picked != null ? File(picked.path) : null;
  }

  Future<void> pickPhoto() async {
    final file = await _pickImage();
    if (file != null) {
      photoFile = file;
      photoUrl = null; // eski URL ni tozalaymiz
      context.read<UploadImageBloc>().add(
        StartUploadImage(file, isFront: true, type: 'photo'),
      );
      notifyListeners();

      await for (final state in context.read<UploadImageBloc>().stream) {
        if (state is UploadImageSuccess && state.type == 'photo') {
          photoId = state.id;
          notifyListeners();
          break;
        } else if (state is UploadImageFailure) {
          errorMessage = state.message;
          notifyListeners();
          break;
        }
      }
    }
  }

  Future<void> pickDocument(bool isFront) async {
    final file = await _pickImage();
    if (file != null) {
      if (isFront) {
        docFront = file;
        docFrontUrl = null;
      } else {
        docBack = file;
        docBackUrl = null;
      }

      context.read<UploadImageBloc>().add(
        StartUploadImage(file, isFront: isFront, type: 'document'),
      );
      notifyListeners();
    }
  }

  Future<void> pickBirthDate(BuildContext context) async {
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

  EditProfileEntity? validateAndBuildModel(GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) return null;

    if (photoFile == null && photoUrl == null) {
      errorMessage = "Фото расмини юкланг";
      notifyListeners();
      return null;
    }
    if (photoFile != null && photoId == null) {
      errorMessage = "Фото расмини юклаш тугашини кутинг";
      notifyListeners();
      return null;
    }

    if ((docFront == null && docFrontUrl == null) ||
        (docBack == null && docBackUrl == null)) {
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

  @override
  void dispose() {
    _subscription.cancel();
    nameController.dispose();
    surnameController.dispose();
    passwordController.dispose();
    telegramController.dispose();
    birthDateController.dispose();
    passportInfoController.dispose();
    super.dispose();
  }
}
