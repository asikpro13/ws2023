import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ws2023/bottomBar.dart';
import 'package:ws2023/globals.dart';
import 'package:http/http.dart' as http;
import 'package:ws2023/login.dart';
import 'package:ws2023/sign.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Home - основной экран приложения, создан 10 ноября в 14 00, Автор - Мазурек Вадим
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Image.asset('assets/home.png')],
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
