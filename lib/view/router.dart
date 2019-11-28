import 'package:flutter/material.dart';

import './../deli_meals/index.dart' as delimeals;

import './../shop/index.dart' as shop;
import './../shop/view/screens/auth.screen.dart';

final routes = {
  delimeals.CategoryScreen.routeName: (context) => delimeals.CategoryScreen(),
  delimeals.MealScreen.routeName: (context) => delimeals.MealScreen(),
  delimeals.FilterScreen.routeName: (context) => delimeals.FilterScreen(),
  shop.Shop.routeName: (context) => shop.Shop(),
  shop.CartScreen.routeName: (context) => shop.CartScreen(),
  shop.ProductDetailsScreen.routeName: (context) => shop.ProductDetailsScreen(),
  shop.FavoritesScreen.routeName: (context) => shop.FavoritesScreen(),
  shop.OrdersScreen.routeName: (context) => shop.OrdersScreen(),
  shop.UserProductsScreen.routeName: (context) => shop.UserProductsScreen(),
  shop.EditProductScreen.routeName: (context) => shop.EditProductScreen(),
  AuthScreen.routeName: (context) => AuthScreen()
};

class Router extends StatefulWidget {
  final dynamic _domain;

  Router(this._domain);

  @override
  _RouterState createState() =>
      _RouterState([delimeals.DeliMeals(), shop.Shop()]);
}

class _RouterState extends State<Router> {
  final List<Widget> _sections;
  int _currentSection = 2;

  _RouterState(this._sections);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) => this._sections[this._currentSection]);
  }
}
