import 'dart:io';
import 'package:kutubxona/core/util/important.dart';

class AuthRegisterScreen extends StatefulWidget {
  const AuthRegisterScreen({super.key});

  @override
  State<AuthRegisterScreen> createState() => _AuthRegisterScreenState();
}

class _AuthRegisterScreenState extends State<AuthRegisterScreen> {
  String? selectedGender;
  String? documentType = 'passport';
  File? frontImage;
  File? backImage;

  Future<void> pickImage(bool isFront) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          frontImage = File(pickedFile.path);
        } else {
          backImage = File(pickedFile.path);
        }
      });
    }
  }
  //  Future<void> pickPassportImage() async {
  //     final pickedImage = await ImagePicker().pickImage(
  //       source: ImageSource.gallery,
  //     );

  //     if (pickedImage != null) {
  //       setState(() {
  //         passportImage = File(pickedImage.path);
  //       });
  //     }
  //   }

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();
  final telegramController = TextEditingController();
  final birthDateController = TextEditingController();
  final passportInfoController = TextEditingController();

  final genders = ['Эркак', 'Аёл'];
  bool obsure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: AppColors().black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              textFieldW(
                label: "Исмингиз",
                controller: nameController,
                hint: 'Исмингиз',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              const Text("Жинс"),
              DropdownButtonFormField<String>(
                borderRadius: BorderRadius.circular(16),
                dropdownColor: AppColors().white,
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
                label: "Фамилиянгиз",
                controller: surnameController,
                hint: 'Фамилиянгиз',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              textFieldW(
                label: "Телеграм username",
                controller: telegramController,
                hint: 'Телеграм ID',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              textFieldW(
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
                      frontImage = null;
                      backImage = null;
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
                      frontImage = null;
                      backImage = null;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              textFieldW(
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
                          imageBox(file: frontImage, isFront: true),
                          const SizedBox(width: 12),
                          imageBox(file: backImage, isFront: false),
                        ],
                      ),
                    ],
                  )
                  : const SizedBox(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    AppNavigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.home,
                    );
                  },
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
    );
  }

  Widget imageBox({required File? file, required bool isFront}) {
    return GestureDetector(
      onTap: () => pickImage(isFront),
      child: Container(
        width: 80,
        height: 80,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            file != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(file, fit: BoxFit.cover),
                )
                : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 28, color: Colors.grey),
                    Icon(Icons.add, size: 18, color: Colors.grey),
                  ],
                ),
      ),
    );
  }
}
