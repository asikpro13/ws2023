import 'package:shared_preferences/shared_preferences.dart';
// globals - глобальные переменные приложения, создан 9 ноября, Автор - Мазурек Вадим

var url_server = 'http://192.168.1.10/';

dynamic setStateIndexCallback;
dynamic setStateButtonsCallback;
dynamic setStatePasswordCallback;
dynamic setStateTextFieldMailCallback;
dynamic setStateButtonSignCallback;
dynamic setStateButtonSignTwoCallback;

dynamic prefs;

var selectedPage = 0;

void initPrefs() async {
  prefs = await SharedPreferences.getInstance();
}