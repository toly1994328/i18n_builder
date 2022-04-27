class LocalInfo {
  final String languageCode;
  final String? countryCode;

  LocalInfo({required this.languageCode, this.countryCode});

  String get shortInfo => "${languageCode}_$countryCode";

  @override
  String toString() {
    return "    Locale('$languageCode','${countryCode ?? ''}')";
  }
}


class Arg{
  final String arg;
  final String full;
  final String? value;

  Arg({required this.arg, this.value,required this.full});
}

class AttrInfo {
  final String name;
  List<Arg> args;

  AttrInfo({required this.name, this.args = const []});

  @override
  String toString() {
    if (args.isEmpty) {
      return "  String get $name => _localizedValues[locale.toString()]!['$name']!;";
    } else {
      String prams = '';
      String value = '';
      args.forEach((Arg a) {
        String arg = a.arg;
        if(a.value==null){
          prams += '  required String $arg,\n';
          value += "  value =  value.replaceAll('{$arg}', $arg);\n";
        }else{
          prams += '  String? $arg,\n';
          // value = value.replaceAll('{${a.full}}', '$arg??"${a.value};\n');
          value += """
    String? defaultValue;
    RegExp reg = RegExp(r'{$arg=(?<value>.*)?}');
    if($arg==null){
      defaultValue = reg.firstMatch(value)?.namedGroup('value');
    }else{
      defaultValue = $arg;
    }
    value = value.replaceAll(reg, defaultValue ?? '');
          """;
        }

      });
      String result = """
  String $name({
$prams
  }) {
  String value = _localizedValues[locale.toString()]!['$name']!;
$value
  return value;
}
      """;
      return result;
    }
  }
}

class ParserResult {
  final List<LocalInfo> locals;
  final List<AttrInfo> attrs;
  final String scriptPath;

  ParserResult({required this.locals, required this.attrs,required this.scriptPath});

  @override
  String toString() {
    return 'ParserResult{locals: $locals, attrs: $attrs}';
  }
}