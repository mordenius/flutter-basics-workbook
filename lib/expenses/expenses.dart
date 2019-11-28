import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/expenses.dart';
import './screens/expenses_screen.dart';

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<Expenses>(
        builder: (_) => Expenses(),
        child: ExpensesScreen(),
      ),
    );
  }
}
