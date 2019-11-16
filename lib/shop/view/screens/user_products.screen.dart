part of shop;

class UserProductsScreen extends StatelessWidget {
  static final String routeName = '/shop/user-products';

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: Provider.of<Products>(context).fetchAndSetProducts(true),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () {
              return Provider.of<Products>(ctx, listen: false)
                  .fetchAndSetProducts(true);
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Consumer<Products>(
                builder: (_ctx, products, _widget) => ListView.builder(
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
            ),
          );
        },
      ),
    );
  }
}
