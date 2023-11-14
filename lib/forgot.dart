import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ws2023/globals.dart';
import 'package:http/http.dart' as http;
import 'package:ws2023/login.dart';
import 'package:ws2023/otp.dart';
import 'package:ws2023/sign.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  // Forgot - экран забыли пароль, создан 10 ноября в 12 56, Автор - Мазурек Вадим
  var isCheck = false;
  var isObscure = true;

  var errorTextMail = null;

  var mailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void sendOtp() async {
    prefs.setString('email', mailController.text);
    var res = await http.post(Uri.parse(url_server + 'api/iforgot/email'), body: {
      'email': mailController.text,
    });
    if (res.statusCode == 200) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTP()));
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
              'Forgot Password',
              style: GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Enter your email address',
              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xffA7A7A7)),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email Address', style: GoogleFonts.roboto(color: const Color(0xffA7A7A7), fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
                  ),
                  StatefulBuilder(builder: (context, setStateTextFieldMail) {
                    return TextField(
                      controller: mailController,
                      onChanged: (value) {
                        if (mailController.text.contains('@') &&
                            mailController.text.contains('.') &&
                            mailController.text.split('@').last.split('.')[0] == mailController.text.split('@').last.split('.')[0].toLowerCase() &&
                            mailController.text.split('@')[0] == mailController.text.split('@')[0].toLowerCase()) {
                          errorTextMail = null;
                        } else {
                          errorTextMail = 'Почта не соотвествует формату';
                        }
                        setStateTextFieldMail(() {});
                        setStateButtonSignTwoCallback(() {});
                      },
                      style: GoogleFonts.roboto(color: Color(0xff3A3A3A), fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          errorText: errorTextMail,
                          border: OutlineInputBorder(),
                          hintText: '***********@mail.com',
                          hintStyle: TextStyle(color: Color(0xffCFCFCF), fontWeight: FontWeight.w500, fontSize: 16)),
                    );
                  }),
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
                            sendOtp();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mailController.text.length != 0 &&
                                      mailController.text.contains('@') &&
                                      mailController.text.contains('.') &&
                                      mailController.text.split('@').last.split('.')[0] ==
                                          mailController.text.split('@').last.split('.')[0].toLowerCase() &&
                                      mailController.text.split('@')[0] == mailController.text.split('@')[0].toLowerCase()
                                  ? Color(0xff0560FA)
                                  : Colors.grey),
                          child: Text(
                            'Send OTP',
                            style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        );
                      })),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Remember password? Back to ',
                        style: GoogleFonts.roboto(color: const Color(0xffA7A7A7), fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          'Sign in',
                          style: GoogleFonts.roboto(color: const Color(0xff0560FA), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
