part of shop;

class OrdersScreen extends StatelessWidget {
  static final routeName = '/cart/orders';

  @override
  Widget build(BuildContext context) {
    Orders orders = Provider.of<Orders>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: orders.fetchAndSetProducts(),
          builder: (_ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (dataSnapshot.error != null) {
              return Center(
                child: Text('Shit happens', style: TextStyle(fontSize: 20)),
              );
            }

            return Consumer<Orders>(
              builder: (_ctx, Orders orders, Widget _widget) =>
                  ListView.builder(
                itemCount: orders.orders.length,
                itemBuilder: (ctx, int index) =>
                    OrderItemTile(orders.orders[index]),
              ),
            );
          }),
    );
  }
}
