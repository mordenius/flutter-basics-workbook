part of shop;

class CartProductItem extends StatelessWidget {
  final CartItem _item;

  CartProductItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
