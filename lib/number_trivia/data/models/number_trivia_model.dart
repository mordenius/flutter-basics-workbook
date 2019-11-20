import 'package:flutter/foundation.dart';

import 'package:flutter_basics_workbook/number_trivia/domain/entities/number_trivia.dart';

const TypeDecode = {'trivia': NumberType.trivia};
const TypeEncode = {NumberType.trivia: 'trivia'};

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel(
      {@required String text, @required int number, @required NumberType type})
      : super(text: text, number: number, type: type);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
        text: json['text'],
        number: (json['number'] as num).toInt(),
        type: TypeDecode[json['type']] ?? NumberType.unknown);
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
      'type': TypeEncode[type] ?? 'trivia'
    };
  }
}
