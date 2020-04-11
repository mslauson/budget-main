class ValueModel {
  String value;
  ValueModel({this.value});
  Map<String, dynamic> toJson() => {"value": value};
}
