import 'package:ht_countries_client/src/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('Custom Exceptions', () {
    final error = Exception('Test error');
    final stackTrace = StackTrace.current;

    test('CountryException stores error and stackTrace', () {
      final exception = CountryException(error, stackTrace);
      expect(exception.error, equals(error));
      expect(exception.stackTrace, equals(stackTrace));
      expect(exception.toString(), contains('CountryException: $error'));
    });

    test('CountryFetchFailure stores error and stackTrace', () {
      final exception = CountryFetchFailure(error, stackTrace);
      expect(exception.error, equals(error));
      expect(exception.stackTrace, equals(stackTrace));
      expect(exception.toString(), contains('CountryFetchFailure: $error'));
    });

    test('CountryNotFound stores error and stackTrace', () {
      final exception = CountryNotFound(error, stackTrace);
      expect(exception.error, equals(error));
      expect(exception.stackTrace, equals(stackTrace));
      expect(exception.toString(), contains('CountryNotFound: $error'));
    });

    test('CountryCreateFailure stores error and stackTrace', () {
      final exception = CountryCreateFailure(error, stackTrace);
      expect(exception.error, equals(error));
      expect(exception.stackTrace, equals(stackTrace));
      expect(exception.toString(), contains('CountryCreateFailure: $error'));
    });

    test('CountryUpdateFailure stores error and stackTrace', () {
      final exception = CountryUpdateFailure(error, stackTrace);
      expect(exception.error, equals(error));
      expect(exception.stackTrace, equals(stackTrace));
      expect(exception.toString(), contains('CountryUpdateFailure: $error'));
    });

    test('CountryDeleteFailure stores error and stackTrace', () {
      final exception = CountryDeleteFailure(error, stackTrace);
      expect(exception.error, equals(error));
      expect(exception.stackTrace, equals(stackTrace));
      expect(exception.toString(), contains('CountryDeleteFailure: $error'));
    });

     test('Exceptions without stackTrace work', () {
      final exception = CountryException(error);
      expect(exception.error, equals(error));
      expect(exception.stackTrace, isNull);
      expect(exception.toString(), contains('CountryException: $error'));

      final fetchFailure = CountryFetchFailure(error);
      expect(fetchFailure.stackTrace, isNull);
      expect(fetchFailure.toString(), contains('CountryFetchFailure: $error'));
    });
  });
}
