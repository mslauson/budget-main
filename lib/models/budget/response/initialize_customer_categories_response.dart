import 'package:main/models/budget/category.dart';

class InitializeCustomerCategoriesResponse {
  String phone;
  List<Category> categories;

  InitializeCustomerCategoriesResponse({this.phone, this.categories});

  InitializeCustomerCategoriesResponse.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    if (json['categories'] != null) {
      categories = new List<Category>();
      json['categories'].forEach((v) {
        categories.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
