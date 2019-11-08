import 'package:flutter/material.dart';

import 'package:flutter_basics_workbook/domain/expenses.dart' as expenses;

import 'append_transaction.dart';
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

  _appendTransaction(String name, double amount, DateTime date) {
    _logic.appendTransaction(name, amount, date);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(children: [
        AppendTransaction(_appendTransaction),
        TransactionList(_logic.transactions),
      ]),
    );
  }
}
