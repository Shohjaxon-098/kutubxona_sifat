import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/domain/entities/register_step2_entity.dart';

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
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          docFront = File(pickedFile.path);
        } else {
          docBack = File(pickedFile.path);
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
        password: passwordController.text,
        telegramId: telegramController.text,
        birthDate: birthDateController.text,
        documentType: documentType!,
        documentNumber: passportInfoController.text,
        documentFile1Path: docFront!,
        documentFile2Path: docBack!,
        libraryId: libraryId,
        userId: userId,
      );
      print(entity.documentFile1Path);
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
                  TextFieldInput(
                    label: "Исмингиз",
                    controller: nameController,
                    hint: 'Исмингиз',
                    keyboardType: TextInputType.name,
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Илтимос, исмни киритинг"
                                : null,
                  ),
                  const SizedBox(height: 16),
                  const Text("Жинс"),
                  GenderSelector(
                    genders: ['Эркак', 'Аёл'],
                    selectedGender: selectedGender,
                    onChanged:
                        (value) => setState(() => selectedGender = value),
                  ),
                  const SizedBox(height: 16),
                  TextFieldInput(
                    label: "Парол",
                    controller: passwordController,
                    obscure: obsure,
                    hint: "***********",
                    validator:
                        (val) =>
                            val == null || val.length < 6
                                ? "Камида 6 та белгидан иборат парол киритинг"
                                : null,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obsure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => setState(() => obsure = !obsure),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFieldInput(
                    label: "Фамилиянгиз",
                    controller: surnameController,
                    hint: 'Фамилиянгиз',
                    keyboardType: TextInputType.name,
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Илтимос, фамилияни киритинг"
                                : null,
                  ),
                  const SizedBox(height: 16),
                  TextFieldInput(
                    label: "Телеграм username",
                    controller: telegramController,
                    hint: 'Телеграм ID',
                    keyboardType: TextInputType.text,
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Илтимос, Telegram ID киритинг"
                                : null,
                  ),
                  const SizedBox(height: 16),
                  TextFieldInput(
                    label: "Туғилган санаси",
                    controller: birthDateController,
                    hint: "кк.оо.йййй",
                    keyboardType: TextInputType.datetime,
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Илтимос, туғилган санани киритинг"
                                : null,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Шахсий тасдиқловчи хужжат",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  RadioListTile<String>(
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
                  TextFieldInput(
                    label:
                        documentType == 'passport'
                            ? "Паспорт маълумотлари *"
                            : "Гувоҳнома ID рақами *",
                    controller: passportInfoController,
                    hint:
                        documentType == 'passport'
                            ? "Паспорт серия рақами | ЖШИР"
                            : "ID рақами",
                    keyboardType: TextInputType.text,
                    validator:
                        (val) =>
                            val == null || val.isEmpty
                                ? "Илтимос, хужжат маълумотини киритинг"
                                : null,
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
}
