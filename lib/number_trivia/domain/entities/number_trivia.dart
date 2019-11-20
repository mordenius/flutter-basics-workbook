import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

enum NumberType { trivia }

class NumberTrivia extends Equatable {
  final String text;
  final int number;
  final NumberType type;

  NumberTrivia(
      {@required this.text, @required this.number, @required this.type})
      : super([text, number, type]);
}
