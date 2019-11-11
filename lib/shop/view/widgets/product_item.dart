part of shop;

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Product _product = Provider.of<Product>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              arguments: _product,
            );
          },
          child: Image.network(
            _product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: theme.primaryColor,
          leading: IconButton(
            icon: Icon(
                _product.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              _product.isFavorite
                  ? _product.removeFromFavorite()
                  : _product.appendToFavorite();
            },
          ),
          title: Text(
            _product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ),
      ),
    );
  }
}
