import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ws2023/globals.dart';
import 'package:http/http.dart' as http;
import 'package:ws2023/home.dart';
import 'package:ws2023/profile.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  // BottomBar - Нижнее меню приложения, создан 10 ноября в 14 30, Автор - Мазурек Вадим

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              selectedPage = 0;
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
            },
            child: Column(
              children: [
                selectedPage == 0
                    ? Container(
                        color: const Color(0xff0560FA),
                        width: 30,
                        height: 2,
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 5,
                ),
                selectedPage == 0
                    ? Image.asset(
                        'assets/bnbs_1.png',
                        width: 30,
                        height: 30,
                      )
                    : Image.asset(
                        'assets/bnb_1.png',
                        width: 30,
                        height: 30,
                      ),
                Text(
                  'Home',
                  style: GoogleFonts.roboto(color: selectedPage == 0 ? const Color(0xff0560FA) : const Color(0xffA7A7A7)),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Column(
            children: [
              selectedPage == 1
                  ? Container(
                      color: const Color(0xff0560FA),
                      width: 30,
                      height: 2,
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 5,
              ),
              selectedPage == 1
                  ? Image.asset(
                      'assets/bnbs_2.png',
                      width: 30,
                      height: 30,
                    )
                  : Image.asset(
                      'assets/bnb_2.png',
                      width: 30,
                      height: 30,
                    ),
              Text(
                'Wallet',
                style: GoogleFonts.roboto(color: selectedPage == 1 ? const Color(0xff0560FA) : const Color(0xffA7A7A7)),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
          Column(
            children: [
              selectedPage == 2
                  ? Container(
                      color: const Color(0xff0560FA),
                      width: 30,
                      height: 2,
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 5,
              ),
              selectedPage == 2
                  ? Image.asset(
                      'assets/bnbs_3.png',
                      width: 30,
                      height: 30,
                    )
                  : Image.asset(
                      'assets/bnb_3.png',
                      width: 30,
                      height: 30,
                    ),
              Text(
                'Track',
                style: GoogleFonts.roboto(color: selectedPage == 2 ? const Color(0xff0560FA) : const Color(0xffA7A7A7)),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              selectedPage = 3;
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Profile()));
            },
            child: Column(
              children: [
                selectedPage == 2
                    ? Container(
                        color: const Color(0xff0560FA),
                        width: 30,
                        height: 2,
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 5,
                ),
                selectedPage == 3
                    ? Image.asset(
                        'assets/bnbs_4.png',
                        width: 30,
                        height: 30,
                      )
                    : Image.asset(
                        'assets/bnb_4.png',
                        width: 30,
                        height: 30,
                      ),
                Text(
                  'Profile',
                  style: GoogleFonts.roboto(color: selectedPage == 3 ? const Color(0xff0560FA) : const Color(0xffA7A7A7)),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
