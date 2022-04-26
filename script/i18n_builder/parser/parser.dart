import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

import 'model.dart';

class Parser {
  Future<ParserResult> parserData(String scriptPath) async {
    Directory dataDir =
        Directory(path.join(scriptPath, 'script', 'i18n_builder', 'data'));
    List<FileSystemEntity> files = dataDir.listSync();
    List<LocalInfo> locals = [];
    List<AttrInfo> texts = [];

    for (int i = 0; i < files.length; i++) {
      if (files[i] is File) {
        File file = files[i] as File;
        locals.add(_parserLocal(file.path));
        if (i == 0) {
          String fileContent = await file.readAsString();
          Map<String, dynamic> decode = json.decode(fileContent);
          decode.forEach((key, value) {
            texts.add(_parserAttr(key,value.toString()));
          });
        }
      }
    }
    return ParserResult(locals: locals, attrs: texts,scriptPath: scriptPath);
  }

  // 解析 LocalInfo
  LocalInfo _parserLocal(String filePath) {
    String name = path.basenameWithoutExtension(filePath);
    String languageCode;
    String? countryCode;
    if (name.contains('_')) {
      languageCode = name.split('_')[0];
      countryCode = name.split('_')[1];
    } else {
      languageCode = name;
    }
    return LocalInfo(
      languageCode: languageCode,
      countryCode: countryCode,
    );
  }

  // 解析属性
  AttrInfo _parserAttr(String key, String value){
   return AttrInfo(name: key);
  }
}
