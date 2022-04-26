import 'dart:io';

import 'builder/builder.dart';
import 'parser/model.dart';
import 'parser/parser.dart';
import 'package:path/path.dart' as path;

main()async{
  Parser parser = Parser();
  String scriptPath = Directory.current.path;
  ParserResult result = await parser.parserData(
      scriptPath
  );
  Builder builder = Builder(dir: path.join(scriptPath,'lib',));
  builder.buildByParserResult(result);

  // Builder builder2 = Builder(dir: path.join(scriptPath,'lib','test2'),caller: 'S');
  // builder2.buildByParserResult(result);
}