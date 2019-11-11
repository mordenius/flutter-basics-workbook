part of shop;

class Products with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items {
    return _items.toList();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }
}