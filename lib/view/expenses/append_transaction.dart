import 'package:flutter/material.dart';

class AppendTransaction extends StatelessWidget {
  final Function _appendTransaction;

  AppendTransaction(this._appendTransaction);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _addTransaction() {
    String title = _titleController.text;
    double amount = double.parse(_amountController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    _appendTransaction(title, amount, DateTime.now());
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
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _addTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _addTransaction(),
            ),
            FlatButton(
                textColor: Theme.of(context).accentColor,
                child: Text("Add Transaction"),
                onPressed: _addTransaction),
          ],
        ),
      ),
    );
  }
}
