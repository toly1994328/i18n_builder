// DO NOT EDIT. This is code generated via package i18n_builder 
import 'package:flutter/material.dart';

import 'data/zh_CH.dart';
import 'data/en_US.dart';

class I18n {
  final Locale locale;
  I18n(this.locale);

  static const Map<String, Map<String,String>> _localizedValues = {
    'zh_CH': zh_CH,'en_US': en_US,
  };

  static I18n of(BuildContext context) {
    return Localizations.of(context, I18n);
  }

  get title => _localizedValues[locale.toString()]!['title'];
get info => _localizedValues[locale.toString()]!['info'];
get increment => _localizedValues[locale.toString()]!['increment'];
}
    