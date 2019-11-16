library shop;

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';

import 'models/http_exception.dart';
import 'providers/auth.provider.dart';
import 'view/screens/auth.screen.dart';
import 'view/screens/splash-screen.dart';
import 'helpers/custom_route.dart';

part './providers/product.dart';
part './providers/products.provider.dart';
part './providers/cart.provider.dart';
part './providers/orders.provider.dart';

part './view/theme.dart';
part './view/shop.dart';

part './view/screens/product_overview.screen.dart';
part './view/screens/cart.screen.dart';
part './view/screens/favorites.screen.dart';
part './view/screens/product_details.screen.dart';
part './view/screens/orders.screen.dart';
part './view/screens/user_products.screen.dart';
part './view/screens/edit_product.screen.dart';

part './view/widgets/products_grid.dart';
part './view/widgets/product_item.dart';
part './view/widgets/badge.dart';
part './view/widgets/cart_product_item.dart';
part './view/widgets/order_item_tile.dart';
part './view/widgets/app_drawer.dart';
part './view/widgets/user_product.dart';

final List<Product> dummyProducts = [
  Product(
    id: 'p1',
    title: 'Red Shirt',
    description: 'A red shirt - it is pretty red!',
    price: 29.99,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  ),
  Product(
    id: 'p2',
    title: 'Trousers',
    description: 'A nice pair of trousers.',
    price: 59.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  ),
  Product(
    id: 'p3',
    title: 'Yellow Scarf',
    description: 'Warm and cozy - exactly what you need for the winter.',
    price: 19.99,
    imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  ),
  Product(
    id: 'p4',
    title: 'A Pan',
    description: 'Prepare any meal you want.',
    price: 49.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  ),
];
