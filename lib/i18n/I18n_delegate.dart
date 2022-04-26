// DO NOT EDIT. This is code generated via package i18n_builder 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'I18n.dart';

class I18nDelegate extends LocalizationsDelegate<I18n> {
  I18nDelegate._();

  final List<Locale> supportedLocales = const [
    Locale('zh','CH'),
Locale('en','US')
  ];

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  Future<I18n> load(Locale locale) {
    return SynchronousFuture<I18n>(I18n(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<I18n> old) => false;

  static I18nDelegate delegate = I18nDelegate._();
}
    