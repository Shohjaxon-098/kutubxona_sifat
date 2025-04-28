import 'package:kutubxona/core/constants/important.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/upload_image/upload_image_bloc.dart';

class RegisterStep2Screen extends StatefulWidget {
  const RegisterStep2Screen({super.key});

  @override
  State<RegisterStep2Screen> createState() => _RegisterStep2ScreenState();
}

class _RegisterStep2ScreenState extends State<RegisterStep2Screen> {
  String? selectedGender;
  String? documentType = 'passport';
  File? docFront;
  File? docBack;
  int? docFrontId;
  int? docBackId;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();
  final telegramController = TextEditingController();
  final birthDateController = TextEditingController();
  final passportInfoController = TextEditingController();
  bool obsure = true;
  String? apiErrorMessage;
  bool? isFront;
  Future<void> pickImage(bool isFront) async {
    final pickedFile = await pickImageFromCamera();

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        if (isFront) {
          docFront = pickedFile;
          context.read<UploadImageBloc>().add(
            StartUploadImage(file, isFront: true),
          );
        } else {
          docBack = pickedFile;
          context.read<UploadImageBloc>().add(
            StartUploadImage(file, isFront: false),
          ); // orqa qismi uchun
        }
      });
    }
  }

  void _submitForm() async {
    final userId = await LocalStorage.getUserId();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User ID topilmadi. Илтимос, қайта рўйхатдан ўтинг."),
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
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

      // ignore: use_build_context_synchronously
      context.read<RegisterStep2Bloc>().add(
        SubmitRegisterStep2Event(entity: entity),
      );
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
      setState(() {
        birthDateController.text = formatted;
      });
    }
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
            }
            if (state is RegisterStep2Success) {
              Navigator.pushNamed(ctx, AppRoutes.home);
            }
          },
        ),
        BlocListener<UploadImageBloc, UploadImageState>(
          listener: (context, state) {
            if (state is UploadImageSuccess) {
              setState(() {
                if (state.isFront) {
                  docFrontId = state.id; // Agar front bo'lsa
                } else {
                  docBackId = state.id; // Agar back bo'lsa
                }
              });
            } else if (state is UploadImageFailure) {
              ScaffoldMessenger.of(
                context,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Рўйхатдан ўтиш',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  buildTextField(
                    "Исмингиз",
                    nameController,
                    TextInputType.name,
                    validateRequired,
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    label: 'Жинс',
                    hintText: 'Жинс',
                    items: ['male', 'famale'],
                    selectedItem: selectedGender,
                    onChanged:
                        (value) => setState(() => selectedGender = value),
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    "Парол",
                    passwordController,
                    TextInputType.text,
                    validatePassword,
                    obscure: true,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    "Фамилиянгиз",
                    surnameController,
                    TextInputType.name,
                    validateRequired,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    "Телеграм username",
                    telegramController,
                    TextInputType.text,
                    validateRequired,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    "Туғилган санаси",
                    birthDateController,
                    TextInputType.datetime,
                    validateRequired,
                    onTap: pickBirthDate,
                    readOnly: true,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Шахсий тасдиқловчи хужжат",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  RadioListTile<String>(
                    activeColor: AppColors().searchInDark,
                    value: 'passport',
                    groupValue: documentType,
                    onChanged:
                        (val) => setState(() {
                          documentType = val;
                          docFront = null;
                          docBack = null;
                        }),
                    title: const Text("Паспорт"),
                  ),
                  RadioListTile<String>(
                    activeColor: AppColors().searchInDark,
                    value: 'birth_certificate',
                    groupValue: documentType,
                    onChanged:
                        (val) => setState(() {
                          documentType = val;
                          docFront = null;
                          docBack = null;
                        }),
                    title: const Text("Туғилганлик ҳақида гувоҳнома"),
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    documentType == 'passport'
                        ? "Паспорт маълумотлари *"
                        : "Гувоҳнома ID рақами *",
                    passportInfoController,
                    TextInputType.text,
                    validateRequired,
                  ),
                  if (documentType == 'passport') ...[
                    const SizedBox(height: 16),
                    const Text(
                      "Ҳужжат расмини юкланг",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        imageBox(file: docFront, onTap: () => pickImage(true)),
                        const SizedBox(width: 12),
                        imageBox(file: docBack, onTap: () => pickImage(false)),
                      ],
                    ),
                  ],
                  const SizedBox(height: 24),
                  if (apiErrorMessage != null)
                    Text(
                      apiErrorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 12),
                  PrimaryButton(text: "Кириш", onPressed: _submitForm),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller,
    TextInputType keyboardType,
    String? Function(String?) validator, {
    bool obscure = false,
    void Function()? onTap,
    bool? readOnly,
  }) {
    return TextFieldInput(
      label: label,
      controller: controller,
      hint: label,
      keyboardType: keyboardType,
      validator: validator,
      obscure: obscure,
      onTap: onTap,
      readOnly: readOnly,
    );
  }

  Widget imageBox({File? file, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child:
            file == null
                ? const Icon(Icons.camera_alt, size: 50)
                : Image.file(file, fit: BoxFit.cover),
      ),
    );
  }
}
