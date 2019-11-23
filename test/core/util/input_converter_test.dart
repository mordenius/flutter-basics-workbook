import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_basics_workbook/core/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
        'should return an integer when the string represents an unsigned integer',
        () {
      const number = 2678;
      final string = number.toString();

      final result = inputConverter.stringToUnsignedInteger(string);

      expect(result, Right(number));
    });

    test('should return a Failure when the string is not an integer', () {
      final string = 'abc';

      final result = inputConverter.stringToUnsignedInteger(string);

      expect(result, Left(InvalidInputFailure()));
    });

    test('should return a Failure when the string is an negative integer', () {
      final string = '-123';

      final result = inputConverter.stringToUnsignedInteger(string);

      expect(result, Left(InvalidInputFailure()));
    });
  });
}
