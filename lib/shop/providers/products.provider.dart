part of shop;

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get favoriteItems {
    return _items.where((Product product) => product.isFavorite).toList();
  }

  List<Product> get items {
    return _items.toList();
  }

  Future<void> addProduct(Product product) async {
    const url = "https://flutter-basics-workbook.firebaseio.com/products.json";

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
        url,
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

  void updateProductById(String id, Product newProduct) {
    final int index = _items.indexWhere((Product product) => product.id == id);

    if (index < 0) {
      addProduct(newProduct);
      return;
    }

    _items[index] = newProduct;

    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }
}
