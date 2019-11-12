part of shop;

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Product _product = Provider.of<Product>(context, listen: false);
    Cart _cart = Provider.of<Cart>(context, listen: false);

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
          leading: Consumer<Product>(
            builder: (BuildContext context, Product product, Widget _notListenWidget) {
              return IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () {
                  product.isFavorite
                      ? product.removeFromFavorite()
                      : product.appendToFavorite();
                },
              );
            },
          ),
          title: Text(
            _product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigator.of(context).pushNamed(CartScreen.routeName);
              _cart.addItem(_product.id, _product.price, _product.title);
            },
          ),
        ),
      ),
    );
  }
}
