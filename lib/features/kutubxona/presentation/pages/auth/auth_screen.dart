import 'package:flutter/material.dart';
import 'package:kutubxona/features/kutubxona/presentation/pages/auth/otp_screen.dart';
import 'package:kutubxona/features/kutubxona/presentation/widgets/textfield_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 291,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 60,
                        offset: Offset(5, 12),
                      ),
                    ],
                    color: Color.fromARGB(255, 42, 54, 121),
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: AssetImage('assets/images/mask.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0,
                              spreadRadius: 5,
                              color: Color.fromARGB(38, 255, 255, 255),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage("assets/icons/logo.png"),
                            scale: 11,
                          ),
                        ),
                      ),
                      SizedBox(height: 33),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Text(
                          'Ассалому алайкум  Хуш келибсиз!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: TextfieldWidget(phoneController: phoneController),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  backgroundColor: Colors.indigo,
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => OtpScreen()),
                  );
                },
                child: Text("Кириш", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
