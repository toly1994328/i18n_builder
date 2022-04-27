import 'dart:io';

import 'package:path/path.dart' as path;

import 'builder/builder.dart';
import 'parser/model.dart';
import 'parser/parser.dart';

main(List<String> args) async {
  print(args);
  //======================配置信息====config=====================//
  // 生成文件的地址:
  // 比如想在 lib/src 下生成文件，可以设置为 path.join('lib','src')
  String distDir = path.join('lib');

  // 调用时的类
  // 比如想通过 S.of(context) 调用，这里可设置为 S
  String caller = 'I18n';

  //==========================================================//
  Parser parser = Parser();
  String scriptPath = Directory.current.path;
  if(args.isNotEmpty){
    scriptPath = Directory.current.parent.parent.path;
    args.forEach((element) { 
      if(element.contains("-D")){
        String dir = element.split('=')[1];
        List<String> dirArgs = dir.split(',');
        String p = '';
        dirArgs.forEach((d) {
          p = path.join(p,d);
        });
        distDir= p;
      }
      if(element.contains("-N")){
        caller = element.split('=')[1];
      }
    });
  }
  ParserResult result = await parser.parserData(scriptPath);
  Builder builder = Builder(
    dir: path.join(scriptPath, distDir),
    caller: caller,
  );
  builder.buildByParserResult(result);
}
