import 'dart:io';
import 'package:kutubxona/core/util/important.dart';

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

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();
  final telegramController = TextEditingController();
  final birthDateController = TextEditingController();
  final passportInfoController = TextEditingController();
  final documentNumber = TextEditingController();

  void _submitForm(BuildContext context) {
    if (docFront == null || docBack == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Илтимос, ҳужжат файлларини танланг!")),
      );
      return;
    }
    final user = RegisterStep2Model(
      firstName: nameController.text,
      lastName: surnameController.text,
      password: passwordController.text,
      telegramId: telegramController.text,
      birthDate: birthDateController.text,
      documentType: documentType!,
      documentNumber: passportInfoController.text,
      document_file1: docFront!,
      document_file2: docBack!,
    );

    context.read<RegisterStep2Bloc>().add(RegisterStep2Submitted(data: user));
  }

  final _formKey = GlobalKey<FormState>();
  bool obsure = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterStep2Bloc, RegisterStep2State>(
      listener: (context, state) {},
      child: Form(
        key: _formKey,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
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
                  ),
                  const SizedBox(height: 20),
                  const Text("Жинс"),
                  GenderSelector(
                    genders: ['Эркак', 'Аёл'],
                    selectedGender: selectedGender,
                    onChanged: (value) {
                      setState(() => selectedGender = value);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFieldInput(
                    label: "Парол",
                    controller: passwordController,
                    obscure: obsure,
                    hint: "***********",
                    suffixIcon:
                        obsure == true
                            ? SvgPicture.asset(
                              AppImages().eyeShow,
                              fit: BoxFit.scaleDown,
                            )
                            : SvgPicture.asset(
                              AppImages().eyeHide,
                              fit: BoxFit.scaleDown,
                            ),
                  ),
                  const SizedBox(height: 20),
                  TextFieldInput(
                    label: "Фамилиянгиз",
                    controller: surnameController,
                    hint: 'Фамилиянгиз',
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 20),
                  TextFieldInput(
                    label: "Телеграм username",
                    controller: telegramController,
                    hint: 'Телеграм ID',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  TextFieldInput(
                    label: "Туғилган санаси",
                    controller: birthDateController,
                    hint: "кк.оо.йййй",
                    keyboardType: TextInputType.datetime,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Шахсий тасдиқловчи хужжат",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  ListTile(
                    title: const Text(
                      "Паспорт",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    leading: Radio<String>(
                      value: 'passport',
                      groupValue: documentType,
                      onChanged: (value) {
                        setState(() {
                          documentType = value!;
                          docFront = null;
                          docBack = null;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      "Туғилганлик ҳақида гувоҳнома",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    leading: Radio<String>(
                      value: 'birth_certificate',
                      groupValue: documentType,
                      onChanged: (value) {
                        setState(() {
                          documentType = value!;
                          docFront = null;
                          docBack = null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
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
                    keyboardType: TextInputType.number,
                    lengthInput: 14,
                  ),
                  const SizedBox(height: 20),

                  documentType == 'passport'
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ҳужжат расмини юкланг",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              imageBox(
                                file: docFront,

                                onTap: () => pickImage(true),
                              ),
                              const SizedBox(width: 12),
                              imageBox(
                                file: docBack,

                                onTap: () => pickImage(false),
                              ),
                            ],
                          ),
                        ],
                      )
                      : const SizedBox(),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    onPressed: () => _submitForm(context),
                    text: "Кириш",
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
