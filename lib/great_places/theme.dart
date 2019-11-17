import 'package:flutter/material.dart';

ThemeData greatPlacesTheme = ThemeData(
    primarySwatch: Colors.indigo,
    fontFamily: "Quicksand",
    appBarTheme: AppBarTheme(
        textTheme: ThemeData.dark().textTheme.copyWith(
              title: TextStyle(
                fontFamily: "Quicksand",
                fontSize: 18,
              ),
            )));
