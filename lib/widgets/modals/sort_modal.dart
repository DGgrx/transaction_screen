import 'package:flutter/material.dart';
import 'package:transaction_screen/services/change_val.dart';

class SortModal {
  // For the transaction List
  bool? sortBy = false;
  bool? filterByCredit = true;
  bool? filterByDebit = true;
  bool? filterByVal = false;
  RangeValues? currentRangeValues = const RangeValues(0, 100000);

  bool? toggleApply = false;

  SortModal(
      {this.sortBy,
      this.filterByVal,
      this.filterByCredit,
      this.filterByDebit,
      this.toggleApply,
      this.currentRangeValues});


  //Bottom Modal Sheet For sorting and filtering
  void showSortPanel(
    BuildContext context,
  ) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setModalState) {
            return Wrap(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                              setModalState(() {
                                filterByCredit = val!;
                                ChangeVal.filterByCredit.value = filterByCredit;
                              });
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
                              setModalState(() {
                                filterByDebit = val!;
                                ChangeVal.filterByDebit.value = filterByDebit;
                              });
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
                              setModalState(() {
                                filterByVal = val!;
                                ChangeVal.filterByVal.value = filterByVal;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          RangeSlider(
                            values: currentRangeValues!,
                            max: 100000,
                            divisions: 1000,
                            labels: RangeLabels(
                              currentRangeValues!.start.round().toString(),
                              currentRangeValues!.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setModalState(() {
                                currentRangeValues = values;
                                ChangeVal.currentRangeValue.value =
                                    currentRangeValues!;
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
                                    ChangeVal.sortBy.value = sortBy;
                                    ChangeVal.filterByDebit.value =
                                        filterByDebit;
                                    ChangeVal.filterByCredit.value =
                                        filterByCredit;
                                    ChangeVal.filterByVal.value = filterByVal;
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
                                  setModalState(() =>
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
                    ]),
              ),
            ]);
          });
        });
  }
}
