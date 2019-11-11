part of shop;

class ProductsGrid extends StatelessWidget {
  final bool showFavoritesOnly;

  ProductsGrid({this.showFavoritesOnly = false});

  @override
  Widget build(BuildContext context) {
    Products products = Provider.of<Products>(context);

    List<Product> items =
        showFavoritesOnly ? products.favoriteItems : products.items;
        
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: items.length,
      itemBuilder: (BuildContext ctx, int index) {
        return GridTile(
          child: ChangeNotifierProvider.value(
            value: items[index],
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
