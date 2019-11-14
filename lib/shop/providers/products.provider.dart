part of shop;

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get favoriteItems {
    return  _items.where((Product product) => product.isFavorite).toList();
  }

  List<Product> get items {
    return  _items.toList();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
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
