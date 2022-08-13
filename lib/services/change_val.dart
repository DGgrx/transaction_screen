import 'package:flutter/material.dart';
import 'package:transaction_screen/models/banks.dart';

class ChangeVal{

  static ValueNotifier<Banks?> bank = ValueNotifier(null);
  static ValueNotifier<String> accountId = ValueNotifier('lrn_001');

  static ValueNotifier<bool?> sortBy = ValueNotifier(false);
  static ValueNotifier<bool?> filterByCredit = ValueNotifier(true);
  static ValueNotifier<bool?> filterByDebit = ValueNotifier(true);
  static ValueNotifier<bool?> filterByVal = ValueNotifier(false);
  static ValueNotifier<RangeValues> currentRangeValue = ValueNotifier(const RangeValues(0,100000));

  //To Listen for this change and then rebuild the list
  static ValueNotifier<bool?> toggleApply = ValueNotifier(false);


}
