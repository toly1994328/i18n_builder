// DO NOT EDIT. This is code generated via  
// i18n_builder By 张风捷特烈 
// github: https://github.com/toly1994328/i18n_builder

import 'package:flutter/material.dart';

import 'data/zh_CN.dart';
import 'data/en_US.dart';

class I18n {
  final Locale locale;
  I18n(this.locale);

  static const Map<String, Map<String,String>> _localizedValues = {
    'zh_CN': zh_CN,'en_US': en_US,
  };

  static I18n of(BuildContext context) {
    return Localizations.of(context, I18n);
  }

  String get title => _localizedValues[locale.toString()]!['title']!;
  String get info => _localizedValues[locale.toString()]!['info']!;
  String info2({
  String? user,
  required String count,

  }) {
  String value = _localizedValues[locale.toString()]!['info2']!;
    String? defaultValue;
    RegExp reg = RegExp(r'{user=(?<value>.*?)}');
    if(user==null){
      defaultValue = reg.firstMatch(value)?.namedGroup('value');
    }else{
      defaultValue = user;
    }
    value = value.replaceAll(reg, defaultValue ?? '');
            value =  value.replaceAll('{count}', count);

  return value;
}
      
  String get increment => _localizedValues[locale.toString()]!['increment']!;
}
