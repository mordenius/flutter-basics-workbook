part of shop;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return _orders.toList();
  }

  void addORder(List<CartItem> products, double total) {
    var now = DateTime.now();
    _orders.insert(
      0,
      OrderItem(
        id: now.toString(),
        amount: total,
        dateTime: now,
        products: products,
      ),
    );
    notifyListeners();
  }
}
