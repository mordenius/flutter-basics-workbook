part of shop;

class CartScreen extends StatelessWidget {
  static final String routeName = '/shop/cart';

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    Orders orders = Provider.of<Orders>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Consumer<Cart>(
                    builder: (_ctx, _cart, _) => Chip(
                      label: Text('\$ ${_cart.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(color: theme.textTheme.title.color)),
                      backgroundColor: theme.primaryColor,
                    ),
                  ),
                  new _OrderButton(orders: orders, cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (_, int index) =>
                  CartProductItem(cart.items.values.toList()[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderButton extends StatefulWidget {
  const _OrderButton({
    Key key,
    @required this.orders,
    @required this.cart,
  }) : super(key: key);

  final Orders orders;
  final Cart cart;

  @override
  __OrderButtonState createState() => __OrderButtonState();
}

class __OrderButtonState extends State<_OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              "ORDER NOW",
              style: TextStyle(
                  color: widget.cart.totalAmount <= 0 || _isLoading
                      ? Colors.grey
                      : theme.primaryColor),
            ),
      onPressed: widget.cart.totalAmount <= 0 || _isLoading
          ? null
          : () {
              setState(() {
                _isLoading = true;
              });
              widget.orders
                  .addORder(widget.cart.items.values.toList(),
                      widget.cart.totalAmount)
                  .then((_) {
                _isLoading = false;
                widget.cart.clear();
              }).catchError((error) {
                print(error);
                setState(() {
                  _isLoading = true;
                });
              });
            },
    );
  }
}
