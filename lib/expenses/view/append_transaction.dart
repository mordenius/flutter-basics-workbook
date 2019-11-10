import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppendTransaction extends StatelessWidget {
  final Function _appendTransaction;

  AppendTransaction(this._appendTransaction);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate;

  void _addTransaction(BuildContext context) {
    String title = _titleController.text;
    double amount = double.parse(_amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    _appendTransaction(title, amount, _selectedDate);

    // Navigator.of(context).pop();
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((DateTime value) {
      if (value == null) {
        return;
      }
      _selectedDate = value;
    });
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
              onSubmitted: (_) => _addTransaction(context),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _addTransaction(context),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(
                    _selectedDate == null
                        ? "Date is not choosen"
                        : DateFormat.yMMMd().format(_selectedDate),
                  ),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text("Choose Date"),
                      onPressed: () => _presentDatePicker(context)),
                ],
              ),
            ),
            RaisedButton(
                textColor: Theme.of(context).accentColor,
                child: Text("Add Transaction"),
                onPressed: () => _addTransaction(context)),
          ],
        ),
      ),
    );
  }
}
