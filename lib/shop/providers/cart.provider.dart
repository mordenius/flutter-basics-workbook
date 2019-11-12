part of shop;

const int DEFAULT_QUANTITY = 1;

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });

  void increment() {
    quantity += DEFAULT_QUANTITY;
    notifyListeners();
  }

  void decrement() {
    quantity -= DEFAULT_QUANTITY;
    notifyListeners();
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return _items;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items[productId].increment();
    } else {
      _items.addAll({
        productId: CartItem(
          id: productId,
          price: price,
          title: title,
          quantity: DEFAULT_QUANTITY,
        )
      });
    }
    notifyListeners();
  }

  void removeById(String id) {
    var isRemoved = _items.remove(id);
    if (isRemoved != null) {
      notifyListeners();
    }
  }
}
