import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:transaction_screen/models/transactions.dart';

import '../services/change_val.dart';

class TransList extends StatefulWidget {
  TransList({this.accountId, required this.trans, Key? key}) : super(key: key);

  String? accountId;
  List<Transactions>? trans;

  @override
  State<TransList> createState() => _TransListState();
}

class _TransListState extends State<TransList> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    count = lengthList();
  }

  int lengthList() {
    int n = 0;
    for (int i = 0; i < widget.trans!.length; i++) {
      if (widget.trans![i].accountId == widget.accountId) {
        n++;
      }
    }
    return n;
  }

  DateFormat transDate = DateFormat('dd/MM/yyyy');

  NumberFormat currency = NumberFormat.currency(
    name: 'INR',
    symbol: '₹',
  );

  String debit = '↗';
  String credit = '↙';

  bool sortBy = false;
  bool filterByCredit = true;
  bool filterByDebit = true;
  bool filterByVal = false;
  RangeValues currentRangeValues = const RangeValues(0, 100000);

  bool toggleApply = false;

  void _showSortPanel() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setModalState) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.77,
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
                        children: const [
                          Text(
                            "Sort & Filter",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0.0),
                        child: Divider(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            child: Text(
                              "Time se Sort Karein",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          RadioListTile(
                            dense: true,
                            value: false,
                            groupValue: sortBy,
                            onChanged: (bool? val) {
                              setModalState(() {
                                sortBy = val!;
                                ChangeVal.sortBy.value = sortBy;
                              });
                            },
                            title: const Text(
                              "Naye Se Purana",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          RadioListTile(
                            dense: true,
                            value: true,
                            groupValue: sortBy,
                            onChanged: (bool? val) {
                              setModalState(() {
                                sortBy = val!;
                                ChangeVal.sortBy.value = sortBy;
                              });
                            },
                            title: const Text(
                              "Purane se Naya",
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            child: Text(
                              "Filter by",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          CheckboxListTile(
                            dense: true,
                            title: const Text(
                              "Credit",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            value: filterByCredit,
                            onChanged: (bool? val) {
                              setModalState(() => filterByCredit = val!);
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            dense: true,
                            title: const Text(
                              "Debit",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            value: filterByDebit,
                            onChanged: (bool? val) {
                              setModalState(() => filterByDebit = val!);
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            dense: true,
                            title: RichText(
                              text: const TextSpan(
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                  children: [
                                    TextSpan(text: 'Amount between '),
                                    TextSpan(
                                        text: '₹0',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' to '),
                                    TextSpan(
                                        text: '₹100,000',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ]),
                            ),
                            value: filterByVal,
                            onChanged: (bool? val) {
                              setModalState(() => filterByVal = val!);
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          RangeSlider(
                            values: currentRangeValues,
                            max: 100000,
                            divisions: 1000,
                            labels: RangeLabels(
                              currentRangeValues.start.round().toString(),
                              currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setModalState(() {
                                currentRangeValues = values;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text('₹0'),
                                  Text('₹100,000')
                                ]),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    side: MaterialStateProperty.all(
                                        const BorderSide(color: Colors.blue)),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 0.0))),
                                onPressed: () {
                                  setModalState(() {
                                    sortBy = false;
                                    filterByCredit = true;
                                    filterByDebit = true;
                                    filterByVal = false;
                                    currentRangeValues =
                                        const RangeValues(0, 100000);
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Reset',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.blue),
                                )),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 0.0))),
                                onPressed: () {
                                  setState(() =>
                                      ChangeVal.toggleApply.value !=
                                      toggleApply);

                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Apply',
                                  style: TextStyle(fontSize: 18.0),
                                )),
                          )
                        ],
                      )
                    ]));
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
      valueListenables: [
        ChangeVal.sortBy,
        ChangeVal.filterByVal,
        ChangeVal.filterByDebit,
        ChangeVal.filterByCredit,
        ChangeVal.toggleApply
      ],
      builder: (context, values, child) {
        return Expanded(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Showing $count results",
                  style: const TextStyle(
                      fontSize: 21.0, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                    onPressed: () {
                      _showSortPanel();
                    },
                    icon: const Icon(
                      Icons.filter_alt,
                      size: 30.0,
                    )),
              ),
              Expanded(
                  child: ListView.builder(
                      reverse: values.elementAt(0),
                      itemCount: widget.trans!.length,
                      itemBuilder: (context, index) {
                        if (widget.trans![index].accountId ==
                            widget.accountId) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 20.0),
                                child: Text(
                                  transDate.format(DateTime.parse(widget
                                      .trans![index].timestamp
                                      .toString())),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 10.0),
                                child: ListTile(
                                    shape: BorderDirectional(
                                      bottom: BorderSide(
                                          color: Colors.black.withOpacity(0.2),
                                          width: 0.8),
                                    ),
                                    title: Text(
                                      widget.trans![index].description
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    trailing: Text(
                                      "${currency.format(widget.trans![index].amount)} ${widget.trans![index].type == 'DEBIT' ? debit : credit}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: widget.trans![index].type ==
                                                  'DEBIT'
                                              ? Colors.red
                                              : Colors.green),
                                    )),
                              ),
                            ],
                          );
                        }
                        return Container();
                      }))
            ],
          ),
        );
      },
    );
  }
}
