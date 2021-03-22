class ChangeBudgetRequestModel {
  String phone;
  String currentBudgetId;
  String newBudgetId;
  String transactionId;

  ChangeBudgetRequestModel(
      {this.phone, this.currentBudgetId, this.newBudgetId, this.transactionId});

  ChangeBudgetRequestModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    currentBudgetId = json['currentBudgetId'];
    newBudgetId = json['newBudgetId'];
    transactionId = json['transactionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['currentBudgetId'] = this.currentBudgetId;
    data['newBudgetId'] = this.newBudgetId;
    data['transactionId'] = this.transactionId;
    return data;
  }
}
