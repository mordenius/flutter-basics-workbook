part of shop;

class OrderItemTile extends StatelessWidget {
  final OrderItem _order;

  OrderItemTile(this._order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${_order.amount}'),
            subtitle:
                Text(DateFormat('dd MM yyyy hh:mm').format(_order.dateTime)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
