part of shop;

class CartProductItem extends StatelessWidget {
  final CartItem _item;

  CartProductItem(this._item);

  @override
  Widget build(BuildContext context) {
    Cart _cart = Provider.of<Cart>(context, listen: false);

    return Dismissible(
      onDismissed: (_) {
        _cart.removeById(_item.id);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove the item from the cart?'),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        );
      },
      key: ValueKey(_item.id),
      background: Container(
        color: theme.errorColor,
        child: Icon(Icons.delete, color: Colors.white, size: 40),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$${_item.price.toStringAsFixed(2)}'),
                ),
              ),
            ),
            title: Text(_item.title),
            subtitle: Text('Total: ${_item.price * _item.quantity}'),
            trailing: Text('${_item.quantity}'),
          ),
        ),
      ),
    );
  }
}
