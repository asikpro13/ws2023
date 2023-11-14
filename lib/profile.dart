import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ws2023/bottomBar.dart';
import 'package:ws2023/globals.dart';
import 'package:http/http.dart' as http;
import 'package:ws2023/login.dart';
import 'package:ws2023/sign.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Profile - экран профиля приложения, создан 10 ноября в 14 00, Автор - Мазурек Вадим
  var passwordController = TextEditingController();

  var isShow = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Profile',
                          style: GoogleFonts.roboto(color: Color(0xffA7A7A7), fontWeight: FontWeight.w500, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffD7D7D7), width: 2), borderRadius: BorderRadius.all(Radius.circular(40))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prefs.getString('name'),
                            style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xff3A3A3A)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Current balance: ',
                                style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff3A3A3A)),
                              ),
                              Text(
                                isShow ? "N" + prefs.getString('balance') : "N*********",
                                style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff0560FA)),
                              )
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            isShow = !isShow;
                            setState(() {});
                          },
                          child: Image.asset(
                            'assets/ps.png',
                            width: 20,
                            height: 20,
                          )),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Image.asset('assets/Frame1.png'))
                ],
              ),
            ),
          ),
          Positioned(
            child: BottomBar(),
            bottom: 0,
          )
        ],
      ),
    );
  }
}
