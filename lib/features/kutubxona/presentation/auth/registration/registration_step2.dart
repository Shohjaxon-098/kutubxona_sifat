import 'dart:io';
import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/register_step2/register_step2_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/register_step2/register_step2_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/register_step2/register_step2_state.dart';
import 'package:kutubxona/features/kutubxona/data/models/register_step2.dart';
import 'package:kutubxona/features/kutubxona/presentation/auth/registration/widgets/image.dart';

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

  final genders = ['Эркак', 'Аёл'];
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

  bool obsure = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterStep2Bloc, RegisterStep2State>(
      listener: (context, state) {
        if (state is RegisterStep2Loading) {
          // loading indicator
          showDialog(
            context: context,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is RegisterStep2Success) {
          Navigator.of(context).pop(); // loadingni yopish
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Muvaffaqiyatli ro'yxatdan o'tildi!")),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (_) => false,
          );
        } else if (state is RegisterStep2Failure) {
          Navigator.of(context).pop(); // loadingni yopish
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Xatolik: ${state.message}")));
        }
      },
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
                textFieldW(
                  context: context,
                  label: "Исмингиз",
                  controller: nameController,
                  hint: 'Исмингиз',
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20),
                const Text("Жинс"),
                DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(16),
                  dropdownColor: Theme.of(context).colorScheme.surface,
                  value: selectedGender,
                  hint: Text(
                    'Эркак',
                    style: TextStyle(
                      color: AppColors().hintColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  items:
                      genders.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() => selectedGender = value);
                  },

                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors().border),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors().border),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors().border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: AppColors().border),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                textFieldW(
                  context: context,
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
                textFieldW(
                  context: context,
                  label: "Фамилиянгиз",
                  controller: surnameController,
                  hint: 'Фамилиянгиз',
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20),
                textFieldW(
                  context: context,
                  label: "Телеграм username",
                  controller: telegramController,
                  hint: 'Телеграм ID',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                textFieldW(
                  context: context,
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
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
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
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
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
                textFieldW(
                  context: context,
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _submitForm(context),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors().primaryColor,

                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Кириш",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget imageBox({required File? file, required bool isFront}) {
  //   return GestureDetector(
  //     onTap: () => pickImage(isFront),
  //     child: Container(
  //       width: 80,
  //       height: 80,
  //       margin: const EdgeInsets.only(right: 10),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.grey),
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child:
  //           file != null
  //               ? ClipRRect(
  //                 borderRadius: BorderRadius.circular(12),
  //                 child: Image.file(file, fit: BoxFit.cover),
  //               )
  //               : const Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Icon(Icons.image, size: 28, color: Colors.grey),
  //                   Icon(Icons.add, size: 18, color: Colors.grey),
  //                 ],
  //               ),
  //     ),
  //   );
  // }
}
