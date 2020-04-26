class GenericSuccessResponseModel {
  bool success;

  GenericSuccessResponseModel({this.success});

  GenericSuccessResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    return data;
  }
}