import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import './great_places/great_places.dart';

import './number_trivia/number_trivia.dart' as nt;

import './curator/curator.dart';

// var expensesLogic = expenseslib.ExpensesLogic();

// class Domain {
//   final expenseslib.ExpensesLogic expenses = expensesLogic;
// }

Future<void> main() async {
  // await FlutterConfig.loadEnvVariables();

  // runApp(GreatPlacesApp());

  // nt.main();

  runApp(Curator());
}


