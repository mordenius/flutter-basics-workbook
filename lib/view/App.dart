import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../shop/providers/auth.provider.dart';
import './../shop/index.dart' as shop;

import './router.dart';

import './../core/view/abstract_app.dart';

var providers = [
  ChangeNotifierProvider.value(value: Auth()),
  ChangeNotifierProxyProvider<Auth, shop.Products>(
      builder: (ctx, auth, previousProducts) => shop.Products(auth.token,
          auth.userId, previousProducts == null ? [] : previousProducts.items)),
  ChangeNotifierProvider.value(value: shop.Cart()),
  ChangeNotifierProxyProvider<Auth, shop.Orders>(
      builder: (ctx, auth, previousOrders) => shop.Orders(auth.token,
          auth.userId, previousOrders == null ? [] : previousOrders.orders)),
];

class App extends StatelessWidget {
  final dynamic _domain;

  App(this._domain);

  @override
  Widget build(BuildContext context) {
    return AbstractApp(
      Router(this._domain),
      providers: providers,
      theme: ThemeData(),
      routes: routes,
    );
  }
}
