part of shop;

class FavoritesScreen extends StatelessWidget {
  static final String routeName = '/shop/favorites';

  final List<Product> loadedProducts = dummyProducts.where((Product product) => product.isFavorite).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        itemBuilder: (BuildContext ctx, int index) {
          return GridTile(
            child: ProductItem(loadedProducts[index]),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10),
      ),
    );
  }
}
