class Banks {
  String? fipId;
  String? fipName;
  int? balance;
  String? accountType;
  String? accountNumber;
  String? accountId;

  Banks(
      {this.fipId,
        this.fipName,
        this.balance,
        this.accountType,
        this.accountNumber,
        this.accountId});

  Banks.fromJson(Map<String, dynamic> json) {
    fipId = json['fipId'];
    fipName = json['fipName'];
    balance = json['balance'];
    accountType = json['accountType'];
    accountNumber = json['accountNumber'];
    accountId = json['accountId'];
  }

}