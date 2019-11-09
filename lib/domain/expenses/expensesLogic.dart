part of expenses;

class Transaction {
  final String id;
  final String name;
  final double cost;
  final DateTime date;

  Transaction({this.id, this.name, this.cost, this.date});
}

class ExpensesLogic {
  List<Transaction> transactions = [];

  void appendTransaction(String name, double cost, DateTime date) {
    Transaction transaction =
        Transaction(id: "tt", name: name, cost: cost, date: date);
    transactions.add(transaction);
  }

  void removeTransaction(Transaction transaction) {
    transactions.remove(transaction);
  }
}
