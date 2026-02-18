import 'package:flutter/foundation.dart';

class LanguageS {
  LanguageS._();

  // Notificador global del idioma actual (por defecto inglés)
  static final ValueNotifier<String> currentLang = ValueNotifier('en');

  static final Map<String, Map<String, String>> _languages = {
    'es': spanish,
    'en': english,
    'pt': portuguese,
    'de': german,
  };

  static String get(String key) {
    // Usamos el valor actual del ValueNotifier
    final languageMap = _languages[currentLang.value] ?? english;
    return languageMap[key] ?? key;
  }

  static const Map<String, String> spanish = {
    TextApp.buttons: "Botones",
    TextApp.name: "Hola",
    TextApp.colors: "Colores",
    TextApp.spacings: "Espaciado",
  };
  static const Map<String, String> english = {
    TextApp.buttons: "Buttons",
    TextApp.name: "Hi",
    TextApp.colors: "Colors",
    TextApp.spacings: "Spacings",
  };
  static const Map<String, String> portuguese = {
    TextApp.buttons: "Botões",
    TextApp.name: "Oi",
    TextApp.colors: "Cores",
    TextApp.spacings: "Espaçamento",
  };
  static const Map<String, String> german = {
    TextApp.buttons: "Knöpfe",
    TextApp.name: "Hallo",
    TextApp.colors: "Farben",
    TextApp.spacings: "Abstände",
  };
}

class TextApp {
  TextApp._();
  static const String buttons = "";
  static const String name = "name";
  static const String colors = "colors";
  static const String spacings = "spacings";
}
