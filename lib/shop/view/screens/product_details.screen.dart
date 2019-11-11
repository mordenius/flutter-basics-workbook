part of shop;

class ProductDetailsScreen extends StatelessWidget {
  static final String routeName = '/shop/product';

  @override
  Widget build(BuildContext context) {
    Product _product = ModalRoute.of(context).settings.arguments as Product;

    // Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: Text(_product.title)),
    );
  }
}
