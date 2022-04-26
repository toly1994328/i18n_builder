class LocalInfo {
  final String languageCode;
  final String? countryCode;

  LocalInfo({required this.languageCode, this.countryCode});

  String get shortInfo =>"${languageCode}_$countryCode";

  @override
  String toString() {
    return "Locale('$languageCode','${countryCode??''}')";
  }
}

class AttrInfo {
  final String name;

  AttrInfo({required this.name});

  @override
  String toString() {
    return "get $name => _localizedValues[locale.toString()]!['$name'];";
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