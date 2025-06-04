import 'package:kutubxona/export.dart';

class RegisterStep2Controller extends ChangeNotifier {
  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController telegramController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController passportInfoController = TextEditingController();

  // Variables
  String? selectedGender;
  String? documentType = 'passport';
  File? docFront;
  File? docBack;
  int? docFrontId;
  int? docBackId;

 
  // API error message
  String? apiErrorMessage;

  // Bloc context holder (required to dispatch events)
  final BuildContext context;

  RegisterStep2Controller({required this.context}) {
    // Subscribe to UploadImageBloc changes
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
        apiErrorMessage = state.message;
        notifyListeners();
      }
    });
  }

  Future<void> pickImage(bool isFront) async {
    final pickedFile = await pickImageFromCamera();

    if (pickedFile != null) {
      final file = File(pickedFile.path);
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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formatted =
          "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      birthDateController.text = formatted;
      notifyListeners();
    }
  }

  Future<void> submitForm(GlobalKey<FormState> formKey) async {
    final userId = await LocalStorage.getUserId();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User ID topilmadi. Илтимос, қайта рўйхатдан ўтинг."),
        ),
      );
      return;
    }

    if (formKey.currentState!.validate()) {
      if (docFront == null || docBack == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Илтимос, ҳужжат файлларини танланг!")),
        );
        return;
      }

      final entity = RegisterStep2Entity(
        firstName: nameController.text,
        lastName: surnameController.text,
        selectGender: selectedGender!,
        telegramUsername: telegramController.text,
        password: passwordController.text,
        birthDate: birthDateController.text,
        documentType: documentType!,
        documentNumber: passportInfoController.text,
        documentFront: docFrontId,
        documentBack: docBackId,
        userId: userId,
        libraryId: AppConfig.libraryId.toString(),
      );

      context.read<RegisterStep2Bloc>().add(
        SubmitRegisterStep2Event(entity: entity),
      );
    }
  }
  void setGender(String? value) {
    selectedGender = value;
    notifyListeners();
  }

  void setDocumentType(String? value) {
    documentType = value;
    docFront = null;
    docBack = null;
    notifyListeners();
  }

  void disposeController() {
    nameController.dispose();
    surnameController.dispose();
    passwordController.dispose();
    telegramController.dispose();
    birthDateController.dispose();
    passportInfoController.dispose();
  }
}
