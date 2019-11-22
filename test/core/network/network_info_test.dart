import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:flutter_basics_workbook/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      const IS_CONNECTED = true;
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) async => IS_CONNECTED);

      final result = await networkInfo.isConnected;

      verify(mockDataConnectionChecker.hasConnection);
      expect(result, IS_CONNECTED);
    });
  });
}
