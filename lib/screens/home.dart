import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transaction_screen/models/db.dart';
import 'package:transaction_screen/models/banks.dart';
import 'package:transaction_screen/models/transactions.dart';
import 'package:transaction_screen/screens/loading.dart';
import 'package:transaction_screen/services/change_val.dart';
import 'package:transaction_screen/widgets/bank_title.dart';
import 'package:transaction_screen/widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Db? data;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    readJson();
  }

  //Function to read the Local Json File
  Future<void> readJson() async {
    setState(() => isLoading = true);
    final String response = await rootBundle.loadString('assets/output.json');
    // print(response);
    Map<String, dynamic> map = jsonDecode(response);
    Db dat = Db.fromJson(map);
    setState(() {
      data = dat;
      isLoading = false;
    });
    // print(data.toString());
  }

  late List<Transactions>? trans = data!.transactions;
  late List<Banks>? banks = data!.banks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Transactions"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Loading()
          : Column(
              children: [
                BankTitle(bank: banks),
                ValueListenableBuilder(
                    valueListenable: ChangeVal.accountId,
                    builder: (context, String accountID, child) {
                      return TransList(
                        trans: trans,
                        accountId: accountID,
                      );
                    }),
              ],
            ),
    );
  }
}
