class Category {
  String id;
  String category;
  String icon;
  bool enabled;

  Category({this.id, this.category, this.icon, this.enabled});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    icon = json['icon'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['icon'] = this.icon;
    data['enabled'] = this.enabled;
    return data;
  }
}
