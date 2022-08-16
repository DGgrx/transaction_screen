import 'package:flutter/material.dart';
import 'package:transaction_screen/models/banks.dart';
import 'package:transaction_screen/services/change_val.dart';

class BankModal {
  List<Banks>? bank;
  String? currentVal = 'lrn_001';

  BankModal({this.bank, this.currentVal});

  void showAccChangePanel(BuildContext context, Banks? bankCur) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setModalState) {
            return Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Account Chunein",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Account Jodein",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          RadioListTile(
                            title: Text("${bank![0].fipName}"),
                            subtitle: Text(
                                "${bank![0].accountType} A/C ${bank![0].accountNumber}"),
                            value: 'lrn_001',
                            groupValue: currentVal,
                            onChanged: (val) {
                              setModalState(() => currentVal = val.toString());
                            },
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                          RadioListTile(
                            title: Text("${bank![1].fipName}"),
                            subtitle: Text(
                                "${bank![1].accountType} A/C ${bank![1].accountNumber}"),
                            value: 'lrn_002',
                            groupValue: currentVal,
                            onChanged: (val) {
                              setModalState(() => currentVal = val.toString());
                            },
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                          RadioListTile(
                            title: Text("${bank![2].fipName}"),
                            subtitle: Text(
                                "${bank![2].accountType} A/C ${bank![2].accountNumber}"),
                            value: 'lrn_003',
                            groupValue: currentVal,
                            onChanged: (val) {
                              setModalState(() => currentVal = val.toString());
                            },
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ChangeVal.accountId.value = currentVal!;

                              for (var val in bank!) {
                                if (val.accountId == currentVal) {
                                  setModalState(() => bankCur = val);
                                  ChangeVal.bank.value = bankCur;
                                }
                              }
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 0.0),
                              child: Text(
                                "Apply",
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
