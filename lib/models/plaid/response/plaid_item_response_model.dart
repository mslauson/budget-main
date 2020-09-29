import 'package:main/models/plaid/response/item_status.dart';
import 'package:main/models/plaid/response/plaid_item.dart';

class PlaidItemResponseModel {
  PlaidItem item;
  ItemStatus status;
  String requestId;

  PlaidItemResponseModel({this.item, this.status, this.requestId});

  PlaidItemResponseModel.fromJson(Map<String, dynamic> json) {
    item = json['item'] != null ? new PlaidItem.fromJson(json['item']) : null;
    status =
        json['status'] != null ? new ItemStatus.fromJson(json['status']) : null;
    requestId = json['request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['request_id'] = this.requestId;
    return data;
  }
}
