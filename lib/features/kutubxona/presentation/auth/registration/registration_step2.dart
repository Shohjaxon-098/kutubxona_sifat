import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/upload_image_bloc.dart';

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

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();
  final telegramController = TextEditingController();
  final birthDateController = TextEditingController();
  final passportInfoController = TextEditingController();
  bool obsure = true;
  String? apiErrorMessage;

  Future<void> pickImage(bool isFront) async {
    final pickedFile = await pickImageFromCamera();

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        if (isFront) {
          docFront = pickedFile;
        } else {
          docBack = pickedFile;
        }
      });
      context.read<UploadImageBloc>().add(StartUploadImage(file));
    }
    if (pickedFile != null) {}
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
        password: passwordController.text,
        telegramId: telegramController.text,
        birthDate: birthDateController.text,
        documentType: documentType!,
        documentNumber: passportInfoController.text,
        libraryId: AppConfig.libraryId.toString(),
        documentFront: docFront!,
        documentBack: docBack!,
        userId: userId,
      );
      context.read<RegisterStep2Bloc>().add(
        SubmitRegisterStep2Event(entity: entity),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterStep2Bloc, RegisterStep2State>(
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
                    items: ['Эркак', 'Аёл'],
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
  }) {
    return TextFieldInput(
      label: label,
      controller: controller,
      hint: label,
      keyboardType: keyboardType,
      validator: validator,
      obscure: obscure,
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
