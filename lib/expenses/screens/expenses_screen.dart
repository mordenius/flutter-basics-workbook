import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../providers/expenses.dart';

import './../widgets/transactions_list.dart';
import './../widgets/append_transaction.dart';

class ExpensesScreen extends StatelessWidget {
  _startAddNew(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: AppendTransaction(null),
            behavior: HitTestBehavior.opaque,
            onTap: () {},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _startAddNew(context);
          }),
      appBar: AppBar(title: Text("Expenses "), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startAddNew(context);
          },
        )
      ]),
      body: Consumer<Expenses>(
        builder: (ctx, expenses, _) {
          return TransactionsList(
              expenses.transactions, expenses.removeTransaction);
        },
      ),
    );
  }
}
