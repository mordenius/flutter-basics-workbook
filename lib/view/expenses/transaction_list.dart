import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_basics_workbook/domain/expenses.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: _getTransactions(),
      ),
    );
  }

  List<Widget> _getTransactions() {
    final List<Widget> transactions = [];

    for (Transaction transaction in _transactions) {
      transactions.add(Container(
        width: double.infinity,
        child: Card(
          child: Column(
            children: [
              Text(transaction.name),
              Text(transaction.cost.toString()),
              Text(DateFormat.yMMMd().format(transaction.date))
            ],
          ),
        ),
      ));
    }

    return transactions;
  }
}
