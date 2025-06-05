
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/auth/presentation/logic/upload_image/upload_image_bloc.dart';
import 'package:kutubxona/features/profile/data/model/edit_profile_model.dart';
import 'package:kutubxona/features/profile/domain/entities/edit_profile_entity.dart';


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

  // Verification type (passport/certificate)
  String _verificationType = 'passport';
  String get verificationType => _verificationType;
  set verificationType(String value) {
    _verificationType = value;
    notifyListeners();
  }

  // Image files
  File? photoFile;
  File? docFront;
  File? docBack;

  // Uploaded image IDs
  int? photoId;
  int? docFrontId;
  int? docBackId;

  // Error message
  String? errorMessage;

  EditProfileController({required this.context}) {
    _listenUploadImageBloc();
  }

  void _listenUploadImageBloc() {
    final uploadImageBloc = context.read<UploadImageBloc>();
    uploadImageBloc.stream.listen((state) {
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

  /// Pick image from gallery
  Future<File?> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    return picked != null ? File(picked.path) : null;
  }

  /// Pick and upload profile photo
  Future<void> pickPhoto() async {
    final file = await _pickImage();
    if (file != null) {
      photoFile = file;
      context.read<UploadImageBloc>().add(
        StartUploadImage(file, isFront: true, type: 'photo'),
      );
      notifyListeners();
    }
  }

  /// Pick and upload document image
  Future<void> pickDocument(bool isFront) async {
    final file = await _pickImage();
    if (file != null) {
      if (isFront) {
        docFront = file;
      } else {
        docBack = file;
      }
      context.read<UploadImageBloc>().add(
        StartUploadImage(file, isFront: isFront, type: 'document'),
      );
      notifyListeners();
    }
  }

  /// Pick birth date
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

  /// Validate form and build profile model
  EditProfileEntity? validateAndBuildModel(GlobalKey<FormState> formKey) {
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
