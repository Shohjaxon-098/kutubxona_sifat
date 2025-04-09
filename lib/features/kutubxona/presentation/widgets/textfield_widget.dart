// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({super.key, required this.phoneController});
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Мобил рақам', style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.lerp(
                  Border(
                    bottom: BorderSide(color: Color(0xffEDEDED)),
                    top: BorderSide(color: Color(0xffEDEDED)),
                    left: BorderSide(color: Color(0xffEDEDED)),
                  ),
                  Border(),
                  0,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(
                  '+998',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  controller: phoneController,
                  cursorHeight: 18,
                  keyboardType: TextInputType.phone,

                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  inputFormatters: [LengthLimitingTextInputFormatter(9)],
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: TextStyle(
                      color: Color(0xffD0D5DD),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    hintText: '_ _  _ _ _  _ _  _ _',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffEDEDED)),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffEDEDED)),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffEDEDED)),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffEDEDED)),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffEDEDED)),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
