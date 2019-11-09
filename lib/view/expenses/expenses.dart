import 'package:flutter/material.dart';

import 'package:flutter_basics_workbook/domain/expenses.dart' as expenses;
import 'package:flutter_basics_workbook/domain/expenses.dart';

import 'append_transaction.dart';
import 'chart.dart';
import 'transaction_list.dart';

class Expenses extends StatefulWidget {
  final expenses.ExpensesLogic _logic;

  Expenses(this._logic);

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState(_logic);
  }
}

class _ExpensesState extends State<Expenses> {
  final expenses.ExpensesLogic _logic;

  _ExpensesState(this._logic);

  List<Transaction> get _recentTransaction {
    return _logic.transactions.where((final Transaction transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _appendTransaction(String name, double amount, DateTime date) {
    _logic.appendTransaction(name, amount, date);
    setState(() {});
  }

  _removeTransaction(Transaction transaction) {
    _logic.removeTransaction(transaction);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(children: [
        AppendTransaction(_appendTransaction),
        Chart(_recentTransaction),
        Expanded(
          child: TransactionList(_logic.transactions, _removeTransaction),
        ),
      ]),
    );
  }
}
