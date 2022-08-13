import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transaction_screen/models/banks.dart';
import 'package:intl/intl.dart';
import 'package:transaction_screen/services/change_val.dart';

class BankTitle extends StatefulWidget {
  BankTitle({required this.bank, Key? key}) : super(key: key);

  List<Banks>? bank;

  @override
  State<BankTitle> createState() => _BankTitleState();
}

class _BankTitleState extends State<BankTitle> {
  NumberFormat currency = NumberFormat.currency(
    name: 'INR',
    symbol: '₹',
  );

  // Initial AccountId
  String? currentVal = 'lrn_001';

  static Banks? bankCur;

  @override
  void initState() {
    super.initState();
    _setCurrentBank();
  }

  void _setCurrentBank() {
    for (var val in widget.bank!) {
      if (val.accountId == currentVal) {
        setState(() => bankCur = val);
        ChangeVal.bank.value = bankCur;
      }
    }
  }

  void _showAccChangePanel() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, StateSetter setModalState) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.5,
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
                          title: Text(widget.bank![0].fipName.toString()),
                          subtitle: Text(
                              "${widget.bank![0].accountType} A/C ${widget.bank![0].accountNumber}"),
                          value: 'lrn_001',
                          groupValue: currentVal,
                          onChanged: (val) {
                            setModalState(() => currentVal = val.toString());
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                        RadioListTile(
                          title: Text(widget.bank![1].fipName.toString()),
                          subtitle: Text(
                              "${widget.bank![1].accountType} A/C ${widget.bank![1].accountNumber}"),
                          value: 'lrn_002',
                          groupValue: currentVal,
                          onChanged: (val) {
                            setModalState(() => currentVal = val.toString());
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                        RadioListTile(
                          title: Text(widget.bank![2].fipName.toString()),
                          subtitle: Text(
                              "${widget.bank![2].accountType} A/C ${widget.bank![2].accountNumber}"),
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
                              _setCurrentBank();
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 0.0),
                              child: Text(
                                "Apply",
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ))
                      ],
                    )
                  ],
                ));
          },
        );
      },
    );
  }

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
                      _showAccChangePanel();
                    },
                    child: const Text(
                      "Account Badlein",
                      style: TextStyle(
                          decoration: TextDecoration.underline, fontSize: 17.0),
                    )),
              )
            ],
          ));
        });
  }
}
