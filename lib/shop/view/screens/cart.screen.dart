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
                  FlatButton(
                    child: Text(
                      "ORDER NOW",
                      style: TextStyle(color: theme.primaryColor),
                    ),
                    onPressed: () {
                      orders.addORder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                  ),
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
