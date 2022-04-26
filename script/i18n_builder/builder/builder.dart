import 'dart:io';

import 'package:path/path.dart' as path;

import '../parser/model.dart';

class Builder {
  final String dir;
  final String caller;

  Builder({
    required this.dir,
    this.caller = 'I18n',
  });

  void buildByParserResult(ParserResult result) async {
    await _ensureDirExist();
    await _buildDelegate(result);
    print('=====${caller}_delegate.dart==文件创建完毕==========');
    await _buildCaller(result);
    print('=====${caller}.dart==文件创建完毕==========');
    await _buildData(result);
    print('=====数据文件创建完毕==========');
  }

  Future<void> _ensureDirExist() async {
    Directory directory = Directory(path.join(dir, 'i18n'));
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    Directory dataDir = Directory(path.join(dir, 'i18n', 'data'));
    if (!dataDir.existsSync()) {
      dataDir.createSync(recursive: true);
    }
  }

  Future<void> _buildDelegate(ParserResult result) async {
    String supportedLocales = result.locals.join(',\n');

    String delegate = """
// DO NOT EDIT. This is code generated via i18n_builder 
// i18n_builder By 张风捷特烈 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '$caller.dart';

class ${caller}Delegate extends LocalizationsDelegate<$caller> {
  ${caller}Delegate._();

  final List<Locale> supportedLocales = const [
    $supportedLocales
  ];

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  Future<$caller> load(Locale locale) {
    return SynchronousFuture<$caller>($caller(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<$caller> old) => false;

  static ${caller}Delegate delegate = ${caller}Delegate._();
}
    """;
    File delegateFile = File(path.join(dir, 'i18n','${caller}_delegate.dart'));
    await delegateFile.writeAsString(delegate);
  }

  Future<void> _buildCaller(ParserResult result) async {
    String attrs = result.attrs.join('\n');
    String import = '';
    String mapStr = '';

    result.locals.forEach((element) {
      import +="""import 'data/${element.shortInfo}.dart';\n""";
      mapStr +="""'${element.shortInfo}': ${element.shortInfo},""";
    });

    String callerContent = """
// DO NOT EDIT. This is code generated via package i18n_builder 
import 'package:flutter/material.dart';

$import
class ${caller} {
  final Locale locale;
  ${caller}(this.locale);

  static const Map<String, Map<String,String>> _localizedValues = {
    $mapStr
  };

  static ${caller} of(BuildContext context) {
    return Localizations.of(context, ${caller});
  }

  $attrs
}
    """;
    File callerFile = File(path.join(dir, 'i18n','$caller.dart'));
    await callerFile.writeAsString(callerContent);
  }

  Future<void> _buildData(ParserResult result) async{
    Directory dataDir = Directory(path.join(result.scriptPath, 'script', 'i18n_builder', 'data'));
    List<FileSystemEntity> files = dataDir.listSync();
    for (int i = 0; i < files.length; i++) {
      if (files[i] is File) {
        File file = files[i] as File;
        String jsonContent = await file.readAsString();
        String name = path.basenameWithoutExtension(file.path);

        File callerFile = File(path.join(dir, 'i18n','data','$name.dart'));
        await callerFile.writeAsString(
"""
const Map<String, String> $name =  $jsonContent;
""");
      }
    }
  }
}
