import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../providers/expenses.dart';

class TransactionsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: Consumer<Expenses>(
        builder: (ctx, expenses, _) {
          return Text('Transaction list');
        },
      ),
    );
  }
}
