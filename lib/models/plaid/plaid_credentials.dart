class PlaidCredentials {
  String label;
  String name;
  String type;

  PlaidCredentials({this.label, this.name, this.type});

  PlaidCredentials.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}
