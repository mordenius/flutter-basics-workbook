part of shop;

class OrdersScreen extends StatelessWidget {
  static final routeName = '/cart/orders';

  @override
  Widget build(BuildContext context) {
    Orders orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (ctx, int index) => OrderItemTile(orders.orders[index]),
      ),
    );
  }
}
