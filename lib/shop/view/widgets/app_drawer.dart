part of shop;

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          title: Text('Hello'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushNamed(Shop.routeName);
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(builder: (ctx) {
              //     return OrdersScreen();
              //   }),
              // );
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context).pushNamed(UserProductsScreen.routeName);
            }),
        Divider(
          height: 25,
        ),
        ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log out'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(Shop.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            }),
      ],
    ));
  }
}
