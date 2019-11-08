import 'package:flutter/material.dart';
import 'package:flutter_basics_workbook/domain/expenses.dart';

class AppendTransaction extends StatelessWidget {
  final Function _appendTransaction;

  AppendTransaction(this._appendTransaction);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _addTransaction() {
    _appendTransaction(_titleController.text, double.parse(_amountController.text), DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'), controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'), controller: _amountController,
            ),
            FlatButton(
                textColor: Colors.greenAccent,
                child: Text("Add Transaction"),
                onPressed: _addTransaction),
          ],
        ),
      ),
    );
  }
}
