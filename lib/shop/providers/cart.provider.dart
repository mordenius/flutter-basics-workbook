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
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return _items;
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double sum = 0;

    _items.forEach((_, CartItem item) {
      sum += item.price * item.quantity;
    });

    return sum;
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

  void removeSingleItemById(String id) {
    if (!_items.containsKey(id)) {
      return;
    }

    if (_items[id].quantity > 1) {
      _items.update(
        id,
        (item) => CartItem(
            id: item.id,
            price: item.price,
            title: item.title,
            quantity: item.quantity - 1),
      );
    } else {
      removeById(id);
    }

    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
