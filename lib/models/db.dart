import 'package:transaction_screen/models/banks.dart';
import 'package:transaction_screen/models/transactions.dart';

class Db {
  List<Banks>? banks;
  List<Transactions>? transactions;

  Db({this.transactions, this.banks});

  Db.fromJson(Map<String, dynamic> json) {

    if (json['banks'] != null) {
      banks = <Banks>[];
      json['banks'].forEach((v) {
        banks!.add(Banks.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
  }

}