part of shop;

class ProductItem extends StatefulWidget {
  final Product _product;

  ProductItem(this._product);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              arguments: widget._product,
            );
          },
          child: Image.network(
            widget._product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: theme.primaryColor,
          leading: IconButton(
            icon: Icon(widget._product.isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () {
              setState(() {
                widget._product.isFavorite
                    ? widget._product.removeFromFavorite()
                    : widget._product.appendToFavorite();
              });
            },
          ),
          title: Text(
            widget._product.title,
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
