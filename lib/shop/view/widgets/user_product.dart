part of shop;

class UserProduct extends StatelessWidget {
  final Product _product;

  UserProduct(this._product);

  @override
  Widget build(BuildContext context) {
    ScaffoldState scaffold = Scaffold.of(context);
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
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,
                    arguments: _product);
              },
              color: theme.primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<Products>(context, listen: false)
                    .removeProduct(_product)
                    .catchError((error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text('Deleting failed.'),
                    ),
                  );
                });
              },
              color: theme.errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
