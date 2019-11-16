part of shop;

class Products with ChangeNotifier {
  String _authToken;
  String _userId;

  static const url =
      "https://flutter-basics-workbook.firebaseio.com/products.json";

  List<Product> _items;

  Products(this._authToken, this._userId, this._items);

  List<Product> get favoriteItems {
    return _items.where((Product product) => product.isFavorite).toList();
  }

  List<Product> get items {
    return _items.toList();
  }

  Future<void> fetchAndSetProducts() async {
    final Response response = await get(url + '?auth=' + _authToken);
    final Map<String, dynamic> data = json.decode(response.body);

    if (data == null) {
      return;
    }

    final favoritesUrl =
        "https://flutter-basics-workbook.firebaseio.com/userFavorites/${_userId}.json" +
            '?auth=' +
            _authToken;

    final Response responseFavorites = await get(favoritesUrl);
    final Map<String, dynamic> dataFavorites = json.decode(response.body);

    data.forEach((String id, dynamic item) {
      _items.add(Product(
        id: id,
        title: item.title,
        description: item.description,
        price: item.price,
        imageUrl: item.imageUrl,
        isFavorite: dataFavorites == null ? false : dataFavorites[id].isFavorite ?? false,
      ));
    });
  }

  Future<void> addProduct(Product product) async {
    final String encodedProduct = json.encode({
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'imageUrl': product.imageUrl,
      'isFavorite': product.isFavorite
    });

    String id;

    try {
      final Response response = await post(
        url + '?auth=' + _authToken,
        body: encodedProduct,
      );

      final data = json.decode(response.body);
      id = data['name'];
    } catch (error) {
      print(error.toString());
      throw error;
    }

    _items.add(
      Product(
        id: id,
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      ),
    );
    notifyListeners();

    return Future.value();
  }

  Future<void> updateProductById(String id, Product newProduct) async {
    final int index = _items.indexWhere((Product product) => product.id == id);

    if (index < 0) {
      return addProduct(newProduct);
    }

    final url =
        "https://flutter-basics-workbook.firebaseio.com/products/${id}.json" +
            '?auth=' +
            _authToken;

    final String encodedProduct = json.encode({
      'title': newProduct.title,
      'description': newProduct.description,
      'price': newProduct.price,
      'imageUrl': newProduct.imageUrl
    });

    try {
      await patch(
        url,
        body: encodedProduct,
      );
    } catch (error) {
      print(error.toString());
      throw error;
    }

    _items[index] = newProduct;

    notifyListeners();
    return Future.value();
  }

  Future<void> removeProduct(Product product) async {
    final existingProductId =
        _items.indexWhere((_product) => _product.id == product.id);
    _items.remove(product);
    notifyListeners();

    final url =
        "https://flutter-basics-workbook.firebaseio.com/products/${product.id}.json" +
            '?auth=' +
            _authToken;

    Response response = await delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProductId, product);
      notifyListeners();
      throw HttpException('Product not deleted');
    }
  }
}
