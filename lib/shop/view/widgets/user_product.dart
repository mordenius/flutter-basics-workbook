part of shop;

class UserProduct extends StatelessWidget {
  final Product _product;

  UserProduct(this._product);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_product.imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
              color: theme.primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
              color: theme.errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
