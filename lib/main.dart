import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';

import 'globals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Onboarding(),
    );
  }
}

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  // Onboarding - Начальный экран приложения, создан 10 ноября в 9 56, Автор - Мазурек Вадим
  var pageController = PageController();
  var indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ), // Отступ
            ExpandablePageView(
                controller: pageController,
                onPageChanged: (index) {
                  indexPage = index;
                  setStateIndexCallback(() {});
                  setStateButtonsCallback(() {});
                },
                children: [
                  Column(children: [
                    Image.asset('assets/bg1.png'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        'Enjoy quick pick-up and delivery to your destination',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ]),
                  Column(children: [
                    Image.asset('assets/bg2.png'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        'Flexible Payment',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(fontSize: 30, color: Color(0xff0560FA), fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ]),
                  Column(children: [
                    Image.asset('assets/bg3.png'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        'Real-time Tracking',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(fontSize: 30, color: Color(0xff0560FA), fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ]),
                ]), // Слайдер с контентом для просмотра
            StatefulBuilder(builder: (context, setStateIndex) {
              setStateIndexCallback = setStateIndex;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: indexPage == 0 ? const Color(0xff0560FA) : const Color(0xffA7A7A7),
                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: indexPage == 1 ? const Color(0xff0560FA) : const Color(0xffA7A7A7),
                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: indexPage == 2 ? const Color(0xff0560FA) : const Color(0xffA7A7A7),
                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                  ),
                ],
              );
            }), // Строчка со счетчком положения слайдера
            const SizedBox(
              height: 100,
            ), // Отступ
            StatefulBuilder(builder: (context, setStateButtons) {
              setStateButtonsCallback = setStateButtons;
              return indexPage != 2
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            pageController.animateToPage(2, duration: const Duration(milliseconds: 400), curve: Curves.ease);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: const Color(0xff0560FA)),
                                borderRadius: const BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              'Skip',
                              style: GoogleFonts.roboto(color: Color(0xff0560FA), fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            pageController.animateToPage(indexPage + 1, duration: const Duration(milliseconds: 400), curve: Curves.ease);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                color: const Color(0xff0560FA),
                                border: Border.all(color: const Color(0xff0560FA)),
                                borderRadius: const BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              'Next',
                              style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff0560FA)),
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              width: 1,
                            )),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account? ',
                                  style: GoogleFonts.roboto(
                                    color: Color(0xffA7A7A7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Sign in',
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff0560FA),
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
            }) // Кнопки для переход по слайдеру или кнопки входа
          ],
        ),
      ),
    );
  }
}
