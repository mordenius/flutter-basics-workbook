import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../shop/providers/auth.provider.dart';
import './../shop/index.dart' as shop;

import './theme.dart';
import './router.dart';

class App extends StatelessWidget {
  final dynamic _domain;

  App(this._domain);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, shop.Products>(
            builder: (ctx, auth, previousProducts) => shop.Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items)),
        ChangeNotifierProvider.value(value: shop.Cart()),
        ChangeNotifierProxyProvider<Auth, shop.Orders>(
            builder: (ctx, auth, previousOrders) => shop.Orders(auth.token,
                previousOrders == null ? [] : previousOrders.orders)),
      ],
      child: MaterialApp(
        theme: theme,
        home: Router(this._domain),
        routes: routes,
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: Text('Unknown route')),
              body: Container(
                margin: EdgeInsets.all(20),
                child: Text('404 page', style: TextStyle(fontSize: 30)),
              ),
            ),
          );
        },
      ),
    );
  }
}
