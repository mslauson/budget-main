class Options {
  int count;
  int offset;

  Options({this.count, this.offset});

  Options.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['offset'] = this.offset;
    return data;
  }
}
