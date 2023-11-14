import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ws2023/globals.dart';
import 'package:http/http.dart' as http;
import 'package:ws2023/home.dart';
import 'package:ws2023/login.dart';
import 'package:ws2023/sign.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  // NewPassword - экран ввода нового пароля для восстановления пароля, создан 10 ноября в 13 30, Автор - Мазурек Вадим
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void newPassword() async {
    var res = await http.post(Uri.parse(url_server + 'api/iforgot/reset'), body: {
      'code': prefs.getString('code'),
      'password': passwordController.text,
      'password_confirmation': passwordController.text,
    });
    if (res.statusCode == 200) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
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
              'New Password',
              style: GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Enter new password',
              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xffA7A7A7)),
            ),
            const SizedBox(
              height: 40,
            ),
            Text('New Password', style: GoogleFonts.roboto(color: const Color(0xffA7A7A7), fontWeight: FontWeight.w500)),
            SizedBox(
              height: 5,
            ),
            StatefulBuilder(builder: (context, setStateTextFieldMail) {
              return TextField(
                controller: passwordController,
                obscureText: true,
                onChanged: (value) {},
                style: GoogleFonts.roboto(color: Color(0xff3A3A3A), fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '**********',
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
                      newPassword();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xff0560FA)),
                    child: Text(
                      'Log in',
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
