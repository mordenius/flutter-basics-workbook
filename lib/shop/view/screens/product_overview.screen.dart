part of shop;

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavoritesOnly = false;
  var _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      Provider.of<Products>(context).fetchAndSetProducts().catchError((error) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("An error occurred"),
            content: Text("Something went wrong."),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      }).then((_) {
        setState(() {
          _isInit = true;
        });
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.All) {
                  _showFavoritesOnly = false;
                } else {
                  _showFavoritesOnly = true;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text("Only Favorites"),
                  value: FilterOptions.Favorites),
              PopupMenuItem(child: Text("Show all"), value: FilterOptions.All),
            ],
          ),
          Consumer<Cart>(
            builder: (_, Cart _cartData, Widget child) => Badge(
              child: child,
              value: _cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: !_isInit
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(showFavoritesOnly: _showFavoritesOnly),
    );
  }
}
