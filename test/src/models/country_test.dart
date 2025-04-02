// ignore_for_file: lines_longer_than_80_chars

import 'package:ht_countries_client/ht_countries_client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

import 'package:uuid/uuid.dart';

void main() {
  group('Country Model', () {
    final id1 = const Uuid().v4();
    final id2 = const Uuid().v4();

    const isoCode = 'DZ';
    const name = 'Algeria';
    const flagUrl = 'https://flagcdn.com/dz.svg';
    final country =
        Country(id: id1, isoCode: isoCode, name: name, flagUrl: flagUrl);

    const isoCode2 = 'US';
    const name2 = 'United States';
    const flagUrl2 = 'https://flagcdn.com/us.svg';
    final country2 =
        Country(id: id2, isoCode: isoCode2, name: name2, flagUrl: flagUrl2);

    final countryJson = {
      'id': id1,
      'iso_code': isoCode,
      'name': name,
      'flag_url': flagUrl,
    };

    test('can be instantiated', () {
      expect(country, isNotNull);
      expect(country.id, id1);
      expect(country.isoCode, isoCode);
      expect(country.name, name);
      expect(country.flagUrl, flagUrl);
    });

    group('Equatable', () {
      test('supports value equality', () {
        expect(
          Country(id: id1, isoCode: isoCode, name: name, flagUrl: flagUrl),
          equals(country),
        );
      });

      test('props are correct', () {
        expect(country.props, equals([id1, isoCode, name, flagUrl]));
      });

      test('instances with different props are not equal', () {
        expect(country, isNot(equals(country2)));
      });
    });

    group('Serialization', () {
      test('fromJson creates correct object', () {
        expect(Country.fromJson(countryJson), equals(country));
      });

      test('fromJson throws CheckedFromJsonException for invalid JSON', () {
        // Provide required keys but with incorrect types (e.g., int for String)
        // to trigger CheckedFromJsonException due to type mismatch during parsing.
        final invalidJson = {
          'id': const Uuid().v4(),
          'iso_code': 123, // Invalid type (int) for required String
          'name': 'Invalid Name',
          'flag_url': 'http://example.com/flag.png', // Valid string here
        };
        expect(
          () => Country.fromJson(invalidJson),
          throwsA(isA<CheckedFromJsonException>()),
        );
      });

      test('toJson returns correct map', () {
        expect(country.toJson(), equals(countryJson));
      });
    });
  });
}
