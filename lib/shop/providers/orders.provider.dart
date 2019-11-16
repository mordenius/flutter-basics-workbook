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
  final String _authToken;
  final String _userId;

  Orders(this._authToken, this._userId, this._orders);

  List<OrderItem> get orders {
    return _orders.toList();
  }

  Future<void> fetchAndSetProducts() async {
    final url = "https://flutter-basics-workbook.firebaseio.com/orders/${_userId}.json?auth=${_authToken}";

    final Response response = await get(url);
    final Map<String, dynamic> data = json.decode(response.body);

    if (data == null) {
      return;
    }

    data.forEach((String id, dynamic item) {
      _orders.add(
        OrderItem(
          id: id,
          amount: double.parse(item['amount']),
          dateTime: DateTime.parse(item['dateTime']),
          products: item['product']
              .map((cp) => {
                    CartItem(
                      id: cp['id'],
                      title: cp['title'],
                      quantity: int.tryParse(cp['quantity']),
                      price: double.parse(cp['price']),
                    )
                  })
              .toList(),
        ),
      );
    });
  }

  Future<void> addORder(List<CartItem> products, double total) async {
    final url = "https://flutter-basics-workbook.firebaseio.com/orders/${_userId}.json?auth=${_authToken}";
    var now = DateTime.now();

    final String encodedProduct = json.encode({
      'amount': total,
      'dateTime': now.toIso8601String(),
      'products': products
          .map((CartItem cp) => {
                'id': cp.id,
                'title': cp.title,
                'quantity': cp.quantity,
                'price': cp.price,
              })
          .toList(),
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

    _orders.insert(
      0,
      OrderItem(
        id: id,
        amount: total,
        dateTime: now,
        products: products,
      ),
    );

    notifyListeners();

    return Future.value();
  }
}
