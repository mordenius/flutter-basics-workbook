part of shop;

class UserProductsScreen extends StatelessWidget {
  static final String routeName = '/shop/user-products';

  @override
  Widget build(BuildContext context) {
    Products products = Provider.of<Products>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Your products'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return products.fetchAndSetProducts();
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: products.items.length,
              itemBuilder: (_, int index) => Column(
                children: <Widget>[
                  UserProduct(products.items[index]),
                  Divider(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
