class BlossomLoginResposne {
  bool success;
  String lastLogin;

  BlossomLoginResposne({this.success, this.lastLogin});

  BlossomLoginResposne.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    lastLogin = json['lastLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['lastLogin'] = this.lastLogin;
    return data;
  }
}
