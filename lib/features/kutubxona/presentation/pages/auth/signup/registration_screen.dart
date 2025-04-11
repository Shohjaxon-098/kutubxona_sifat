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
  File? passportImage;

  Future<void> pickPassportImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        passportImage = File(pickedImage.path);
      });
    }
  }

  Future<void> takePassportImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      setState(() {
        passportImage = File(pickedImage.path);
      });
    }
  }

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();
  final telegramController = TextEditingController();
  final birthDateController = TextEditingController();
  final passportInfoController = TextEditingController();

  final genders = ['Эркак', 'Аёл'];

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
              SizedBox(height: 24),
              textFieldW(
                label: "Исмингиз",
                controller: nameController,
                hint: 'Исмингиз',
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
                obscure: true,
                hint: "***********",
              ),
              const SizedBox(height: 20),
              textFieldW(
                label: "Фамилиянгиз",
                controller: surnameController,
                hint: 'Фамилиянгиз',
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
                keyboardType: TextInputType.number,
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
                    setState(() => documentType = value);
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
                    setState(() => documentType = value);
                  },
                ),
              ),
              const SizedBox(height: 20),
              textFieldW(
                label: "Паспорт маълумотлари",
                controller: passportInfoController,
                hint: "Паспорт серия рақами | ЖШИР",
                keyboardType: TextInputType.number,
                lengthInput: 14,
              ),
              const SizedBox(height: 20),
              const Text(
                "Ҳужжат расмини юкланг",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildImageUploadPlaceholder(),
                  const SizedBox(width: 12),
                  _buildImageUploadPlaceholder(),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // submit logika shu yerga yoziladi
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
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

  Widget _buildImageUploadPlaceholder() {
    return GestureDetector(
      onTap: takePassportImage,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors().border,
        ),
        child:
            passportImage != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(passportImage!, fit: BoxFit.cover),
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 30, color: AppColors().grey),
                  ],
                ),
      ),
    );
  }
}
