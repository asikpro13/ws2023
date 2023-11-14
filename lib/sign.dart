import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ws2023/globals.dart';
import 'package:http/http.dart' as http;
import 'package:ws2023/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Sign up - экран регистрации, создан 10 ноября в 11 56, Автор - Мазурек Вадим
  var isCheck = false;
  var isObscure = true;

  var errorTextMail;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var mailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void auth() async {
    var res = await http.post(Uri.parse(url_server + 'api/register'), body: {
      'name': nameController.text,
      'email': mailController.text,
      'password': passwordController.text,
      'confirm_password': passwordController.text,
    });
    print(res.body);
    if (res.statusCode == 200) {
      prefs.setString('name', nameController.text);
      prefs.setString('email', mailController.text);
      prefs.setString('password', passwordController.text);
      prefs.setString('phone', phoneController.text);
      prefs.setString('token', jsonDecode(res.body)['data']['token']);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
    }
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
              'Create an account',
              style: GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Complete the sign up process to get started',
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
                  Text('Full Name', style: GoogleFonts.roboto(color: const Color(0xffA7A7A7), fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: nameController,
                    onChanged: (value) {
                      setStateButtonSignCallback(() {});
                    },
                    style: GoogleFonts.roboto(color: Color(0xff3A3A3A), fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Abecd   fsgh',
                        hintStyle: TextStyle(color: Color(0xffCFCFCF), fontWeight: FontWeight.w500, fontSize: 16)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Phone Number', style: GoogleFonts.roboto(color: const Color(0xffA7A7A7), fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: phoneController,
                    onChanged: (value) {
                      setStateButtonSignCallback(() {});
                    },
                    style: GoogleFonts.roboto(color: Color(0xff3A3A3A), fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '000000000000',
                        hintStyle: TextStyle(color: Color(0xffCFCFCF), fontWeight: FontWeight.w500, fontSize: 16)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Email Address', style: GoogleFonts.roboto(color: const Color(0xffA7A7A7), fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
                  ),
                  StatefulBuilder(builder: (context, setStateTextFieldMail) {
                    setStateTextFieldMailCallback = setStateTextFieldMail;
                    return TextField(
                      onChanged: (value) {
                        if (mailController.text.contains('@') &&
                            mailController.text.contains('.') &&
                            mailController.text.split('@').last.split('.')[0] == mailController.text.split('@').last.split('.')[0].toLowerCase() &&
                            mailController.text.split('@')[0] == mailController.text.split('@')[0].toLowerCase()) {
                          errorTextMail = null;
                        } else {
                          errorTextMail = 'Почта не соотвествует формату';
                        }
                        setStateTextFieldMailCallback(() {});
                        setStateButtonSignCallback(() {});
                      },
                      controller: mailController,
                      style: GoogleFonts.roboto(color: Color(0xff3A3A3A), fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          errorText: errorTextMail,
                          border: OutlineInputBorder(),
                          hintText: '***********@mail.com',
                          hintStyle: TextStyle(color: Color(0xffCFCFCF), fontWeight: FontWeight.w500, fontSize: 16)),
                    );
                  }),
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
                      onChanged: (value) {
                        setStateButtonSignCallback(() {});
                      },
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
                      Expanded(
                        flex: 1,
                        child: StatefulBuilder(builder: (context, setStateCheckbox) {
                          return Checkbox(
                              value: isCheck,
                              onChanged: (value) {
                                isCheck = value!;
                                setStateCheckbox(() {});
                                setStateButtonSignCallback(() {});
                              });
                        }),
                      ),
                      Expanded(
                        flex: 10,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(text: 'By ticking this box, you agree to our ', style: GoogleFonts.roboto(color: const Color(0xffA7A7A7))),
                                TextSpan(text: 'Terms and conditions and private policy', style: GoogleFonts.roboto(color: const Color(0xffEBBC2E)))
                              ],
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
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
                          style: ElevatedButton.styleFrom(
                              backgroundColor: nameController.text.length != 0 &&
                                      phoneController.text.length != 0 &&
                                      passwordController.text.length != 0 &&
                                      isCheck
                                  ? Color(0xff0560FA)
                                  : Colors.grey),
                          child: Text(
                            'Sign Up',
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
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          'Sign in',
                          style: GoogleFonts.roboto(color: const Color(0xff0560FA), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'or sign in using',
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
