import './../models/transaction.dart';

class ExpensesController {
  List<Transaction> transactions = [];

  void appendTransaction(String name, double cost, [DateTime date]) {
    final String _id = _generateId();
    final DateTime _date = date != null ? date : DateTime.now();

    final Transaction transaction =
        Transaction(id: _id, name: name, cost: cost, date: _date);
    transactions.add(transaction);
  }

  void removeTransaction(String id) {
    transactions.remove({id: id});
  }

  String _generateId() {
    return "t1";
  }
}
