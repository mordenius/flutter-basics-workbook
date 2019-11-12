part of shop;

class ProductDetailsScreen extends StatelessWidget {
  static final String routeName = '/shop/product';

  @override
  Widget build(BuildContext context) {
    Product _product = ModalRoute.of(context).settings.arguments as Product;

    // Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: Text(_product.title)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(_product.imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: 10),
            Text(
              '\$${_product.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0 ),
                child: Text(
                  _product.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
