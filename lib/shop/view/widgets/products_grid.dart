part of shop;

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<Products>(context).items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (BuildContext ctx, int index) {
        return GridTile(
          child: ChangeNotifierProvider(
            builder: (BuildContext context) => products[index],
            child: ProductItem(),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10),
    );
  }
}
