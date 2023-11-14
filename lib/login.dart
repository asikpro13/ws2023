import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ws2023/forgot.dart';
import 'package:ws2023/globals.dart';
import 'package:http/http.dart' as http;
import 'package:ws2023/home.dart';
import 'package:ws2023/sign.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Login - экран авторизации, создан 10 ноября в 12 56, Автор - Мазурек Вадим
  var isCheck = false;
  var isObscure = true;

  var errorTextMail;

  var mailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void auth() async {
    var res = await http.post(Uri.parse(url_server + 'api/login'), body: {
      'email': mailController.text,
      'password': passwordController.text,
    });
    if (res.statusCode == 200) {
      prefs.setString('token', jsonDecode(res.body)['data']['token']);
      var resp = await http.get(Uri.parse(url_server + 'api/user'), headers: {
        'Authorization': 'Bearer ${prefs.getString('token')}',
      });
      if (resp.statusCode == 200) {
        print(resp.body);
        prefs.setString('id', jsonDecode(resp.body)['data']['id'].toString());
        prefs.setString('email', jsonDecode(resp.body)['data']['email']);
        prefs.setString('name', jsonDecode(resp.body)['data']['name']);
        prefs.setString('avatar', jsonDecode(resp.body)['data']['avatar']);
        prefs.setString('balance', jsonDecode(resp.body)['data']['balance'].toString());
        prefs.setString('password', passwordController.text);
        selectedPage = 0;
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      }
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
              'Welcome Back',
              style: GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Fill in your email and password to continue',
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
                  TextField(
                    controller: mailController,
                    onChanged: (value) {},
                    style: GoogleFonts.roboto(color: Color(0xff3A3A3A), fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '***********@mail.com',
                        hintStyle: TextStyle(color: Color(0xffCFCFCF), fontWeight: FontWeight.w500, fontSize: 16)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Password', style: GoogleFonts.roboto(color: const Color(0xffA7A7A7), fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
                  ),
                  StatefulBuilder(builder: (context, setStatePassword) {
                    setStatePasswordCallback = setStatePassword;
                    return TextField(
                      controller: passwordController,
                      onChanged: (value) {},
                      style: GoogleFonts.roboto(color: Color(0xff3A3A3A), fontWeight: FontWeight.w500),
                      obscureText: isObscure,
                      decoration: InputDecoration(
                          suffixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                isObscure = !isObscure;
                                setStatePassword(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                width: 20,
                                height: 20,
                                child: Image.asset(
                                  'assets/ps.png',
                                  color: Colors.black,
                                ),
                              )),
                          border: const OutlineInputBorder(),
                          hintText: '**********',
                          hintStyle: const TextStyle(color: Color(0xffCFCFCF), fontWeight: FontWeight.w500, fontSize: 16)),
                    );
                  }),
                  Row(
                    children: [
                      StatefulBuilder(builder: (context, setStateCheckboxRemember) {
                        return Checkbox(
                            value: isCheck,
                            onChanged: (value) {
                              isCheck = !isCheck;
                              setStateCheckboxRemember(() {});
                            });
                      }),
                      Text(
                        'Remember password',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.w500, color: Color(0xffA7A7A7)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: StatefulBuilder(builder: (context, setStateButtonSign) {
                        setStateButtonSignCallback = setStateButtonSign;
                        return ElevatedButton(
                          onPressed: () {
                            auth();
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xff0560FA)),
                          child: Text(
                            'Log in',
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
                        'Already have an account?',
                        style: GoogleFonts.roboto(color: const Color(0xffA7A7A7), fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.roboto(color: const Color(0xff0560FA), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Forgot()));
                          },
                          child: Text(
                            'Forgot password?',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(fontWeight: FontWeight.w500, color: Color(0xff0560FA)),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'or log in using',
                            style: GoogleFonts.roboto(color: const Color(0xffA7A7A7), fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            'assets/google.png',
                            width: 15,
                            height: 15,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
