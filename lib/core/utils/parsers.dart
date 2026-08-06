class Parsers{
  Parsers._();

  static double toDouble(dynamic value){
    if(value is double) return value;
    if(value is int) return value.toDouble();
    if(value is String) return double.parse(value);
    throw FormatException("Not convert from $value to double");
  }

}