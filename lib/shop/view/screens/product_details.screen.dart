part of shop;

class ProductDetailsScreen extends StatelessWidget {
  static final String routeName = '/shop/product';

  @override
  Widget build(BuildContext context) {
    Product _product = ModalRoute.of(context).settings.arguments as Product;

    // Provider.of<Products>(context);
    return Scaffold(
      // appBar: AppBar(title: Text(_product.title)),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(_product.title),
              background: Hero(
                tag: _product.id,
                child: Image.network(_product.imageUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(height: 10),
            Text(
              '\$${_product.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  _product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            )
          ]))
        ],
      ),
    );
  }
}
