class Reimbursement {
  bool reimbursed;
  int amount;
  List<String> linkedTransactions;

  Reimbursement({this.reimbursed, this.amount, this.linkedTransactions});

  Reimbursement.fromJson(Map<String, dynamic> json) {
    reimbursed = json['reimbursed'];
    amount = json['amount'];
    linkedTransactions = json['linkedTransactions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reimbursed'] = this.reimbursed;
    data['amount'] = this.amount;
    data['linkedTransactions'] = this.linkedTransactions;
    return data;
  }
}
