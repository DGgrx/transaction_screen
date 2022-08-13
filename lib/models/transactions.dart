class Transactions {
  String? fipId;
  String? accountNumber;
  int? amount;
  String? type;
  String? accountId;
  String? description;
  String? timestamp;

  Transactions(
      {this.fipId,
        this.accountNumber,
        this.amount,
        this.type,
        this.accountId,
        this.description,
        this.timestamp});

  Transactions.fromJson(Map<String, dynamic> json) {
    fipId = json['fipId'];
    accountNumber = json['accountNumber'];
    amount = json['amount'];
    type = json['type'];
    accountId = json['accountId'];
    description = json['description'];
    timestamp = json['timestamp'];
  }



}
