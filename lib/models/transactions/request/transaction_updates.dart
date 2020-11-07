class TransactionUpdates {
  String transactionId;
  String tags;
  String budget;
  String notes;

  TransactionUpdates({this.transactionId, this.tags, this.budget, this.notes});

  TransactionUpdates.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    tags = json['tags'];
    budget = json['budget'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.transactionId;
    data['tags'] = this.tags;
    data['budget'] = this.budget;
    data['notes'] = this.notes;
    return data;
  }
}