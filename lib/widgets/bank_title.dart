import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transaction_screen/models/banks.dart';
import 'package:intl/intl.dart';
import 'package:transaction_screen/services/change_val.dart';
import 'package:transaction_screen/widgets/modals/bank_modal.dart';

class BankTitle extends StatefulWidget {
  BankTitle({required this.bank, Key? key}) : super(key: key);

  List<Banks>? bank;

  @override
  State<BankTitle> createState() => _BankTitleState();
}

class _BankTitleState extends State<BankTitle> {
  //Currency Format
  NumberFormat currency = NumberFormat.currency(
    name: 'INR',
    symbol: '₹',
  );

  static Banks? bankCur;
  dynamic modal;

  //To initialise the current value of the bank (Defaults to bank[0]{AXIS Banks})
  @override
  void initState() {
    super.initState();
    modal = BankModal(
      bank: widget.bank,
      currentVal: 'lrn_001',
    );
    _setCurrentBank();
  }

  void _setCurrentBank() {
    for (var val in widget.bank!) {
      if (val.accountId == modal.currentVal) {
        setState(() => bankCur = val);
        ChangeVal.bank.value = bankCur;
      }
    }
  }

  //Bank Tile Widget
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ChangeVal.bank,
      builder: (context, Banks? newBank, child) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: SvgPicture.asset(
                  "assets/${newBank?.fipId?.toLowerCase()}.svg",
                  semanticsLabel: '${newBank?.fipName} Logo',
                  height: 40.0,
                ),
                title: Text(
                  "${newBank?.fipName}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                trailing: Text(
                  currency.format(newBank?.balance).toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  "${newBank?.accountType} A/C",
                  style: const TextStyle(fontSize: 15.0),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: TextButton(
                  onPressed: () {
                    modal.showAccChangePanel(context, bankCur);
                  },
                  child: const Text(
                    "Account Badlein",
                    style: TextStyle(
                        decoration: TextDecoration.underline, fontSize: 17.0),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
