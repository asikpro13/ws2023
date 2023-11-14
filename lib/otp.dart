import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ws2023/globals.dart';
import 'package:http/http.dart' as http;
import 'package:ws2023/login.dart';
import 'package:ws2023/newPassword.dart';
import 'package:ws2023/sign.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  // OTP - экран ввода кода для восстановления пароля, создан 10 ноября в 13 30, Автор - Мазурек Вадим
  var codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void sendOtp() async {
    var res = await http.post(Uri.parse(url_server + 'api/iforgot/email'), body: {
      'email': prefs.getString('email'),
    });
    if (res.statusCode == 200) {}
    print(res.body);
  }

  void codeCheck() async {
    var res = await http.post(Uri.parse(url_server + 'api/iforgot/codecheck'), body: {
      'code': codeController.text,
    });
    if (res.statusCode == 200) {
      prefs.setString('code', codeController.text);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewPassword()));
    }
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OTP Verification',
              style: GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Enter the 6 digit numbers sent to your email',
              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xffA7A7A7)),
            ),
            const SizedBox(
              height: 40,
            ),
            PinCodeTextField(
              controller: codeController,
              appContext: context,
              length: 6,
              pinTheme: PinTheme(
                selectedColor: Color(0xffEC8000),
                activeColor: Color(0xffEC8000),
                inactiveColor: Color(0xffEC8000),
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'If you didn’t receive code, ',
                  style: GoogleFonts.roboto(color: Color(0xffA7A7A7), fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    sendOtp();
                  },
                  child: Text(
                    'Resend',
                    style: GoogleFonts.roboto(color: Color(0xff0560FA), fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: StatefulBuilder(builder: (context, setStateButtonSign) {
                  setStateButtonSignTwoCallback = setStateButtonSign;
                  return ElevatedButton(
                    onPressed: () {
                      codeCheck();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xff0560FA)),
                    child: Text(
                      'Set New Password',
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  );
                })),
          ],
        ),
      ),
    );
  }
}
