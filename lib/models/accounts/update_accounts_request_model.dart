class UpdateAccountRequestModel {
  String id;
  String phone;
  String accessToken;

  UpdateAccountRequestModel({this.id, this.phone, this.accessToken});

  UpdateAccountRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['accessToken'] = this.accessToken;
    return data;
  }
}
