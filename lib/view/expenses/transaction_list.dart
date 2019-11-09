import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_basics_workbook/domain/expenses.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    if (_transactions.isEmpty) {
      return Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(20.0),
              child: Text("Not any transaction yet!",
                  style: Theme.of(context).textTheme.title)),
          Container(
              height: 250,
              child: Image.asset(
                "assets/images/waiting.png",
                fit: BoxFit.fitHeight,
              )),
        ],
      );
    }

    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _transactions.length,
        itemBuilder: _getTransaction,
      ),
    );
  }

  Widget _getTransaction(BuildContext ctx, int index) {
    Transaction transaction = _transactions[index];
    return Container(
      width: double.infinity,
      child: Card(
        child: Column(
          children: [
            Text(transaction.name, style: Theme.of(ctx).textTheme.title),
            Text(transaction.cost.toStringAsFixed(2)),
            Text(DateFormat.yMMMd().format(transaction.date))
          ],
        ),
      ),
    );
  }
}