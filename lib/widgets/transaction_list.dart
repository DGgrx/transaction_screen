import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:transaction_screen/models/transactions.dart';
import 'package:transaction_screen/widgets/modals/sort_modal.dart';
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
  dynamic modal ;

  @override
  void initState() {
    super.initState();
    modal = SortModal(
      sortBy: false,
      filterByVal: false,
      filterByCredit: true,
      filterByDebit: true,
      toggleApply: false,
      currentRangeValues: const RangeValues(0, 100000),
    );
    count = lengthList();
  }


  int lengthList() {
    int n = 0;
    for (int i = 0; i < widget.trans!.length; i++) {
      if (widget.trans![i].accountId == widget.accountId) {
        if (modal.filterByCredit && modal.filterByDebit
            ? widget.trans![i].type == 'CREDIT' ||
                widget.trans![i].type == 'DEBIT'
            : modal.filterByCredit
                ? widget.trans![i].type == 'CREDIT'
                : modal.filterByDebit
                    ? widget.trans![i].type == 'DEBIT'
                    : false) {
          if (modal.filterByVal
              ? widget.trans![i].amount! >= modal.currentRangeValues.start &&
                  widget.trans![i].amount! <= modal.currentRangeValues.end
              : true) {
            n++;
          }
        }
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



  //Transaction List Scrollable Widget
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
                  "Showing ${lengthList()} of $count results",
                  style: const TextStyle(
                      fontSize: 21.0, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                    onPressed: () {
                      modal.showSortPanel(context);
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
                          if (modal.filterByCredit && modal.filterByDebit
                              ? widget.trans![index].type == 'CREDIT' ||
                                  widget.trans![index].type == 'DEBIT'
                              : modal.filterByCredit
                                  ? widget.trans![index].type == 'CREDIT'
                                  : modal.filterByDebit
                                      ? widget.trans![index].type == 'DEBIT'
                                      : false) {
                            if (modal.filterByVal
                                ? widget.trans![index].amount! >=
                                        modal.currentRangeValues.start &&
                                    widget.trans![index].amount! <=
                                        modal.currentRangeValues.end
                                : true) {
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
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              width: 0.8),
                                        ),
                                        title: Text(
                                          widget.trans![index].description
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                        trailing: Text(
                                          "${currency.format(widget.trans![index].amount)} ${widget.trans![index].type == 'DEBIT' ? debit : credit}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                              color:
                                                  widget.trans![index].type ==
                                                          'DEBIT'
                                                      ? Colors.red
                                                      : Colors.green),
                                        )),
                                  ),
                                ],
                              );
                            }
                          }
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
