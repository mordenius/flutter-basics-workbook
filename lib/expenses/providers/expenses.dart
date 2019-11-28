import 'package:flutter/foundation.dart';

import './../models/transaction.dart';

class Expenses with ChangeNotifier {
  List<Transaction> transactions = [];

  void appendTransaction(String name, double cost, [DateTime date]) {
    final String _id = _generateId();
    final DateTime _date = date != null ? date : DateTime.now();

    final Transaction transaction =
        Transaction(id: _id, name: name, cost: cost, date: _date);
    transactions.add(transaction);
    notifyListeners();
  }

  void removeTransaction(String id) {
    transactions.remove({id: id});
    notifyListeners();
  }

  String _generateId() {
    return "t1";
  }
}
