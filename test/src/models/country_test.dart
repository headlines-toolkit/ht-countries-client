import 'package:ht_countries_client/ht_countries_client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('Country Model', () {
    const isoCode = 'DZ';
    const name = 'Algeria';
    const flagUrl = 'https://flagcdn.com/dz.svg';
    const country = Country(isoCode: isoCode, name: name, flagUrl: flagUrl);

    const isoCode2 = 'US';
    const name2 = 'United States';
    const flagUrl2 = 'https://flagcdn.com/us.svg';
    const country2 = Country(isoCode: isoCode2, name: name2, flagUrl: flagUrl2);

    final countryJson = {
      'iso_code': isoCode,
      'name': name,
      'flag_url': flagUrl,
    };

    test('can be instantiated', () {
      expect(country, isNotNull);
      expect(country.isoCode, isoCode);
      expect(country.name, name);
      expect(country.flagUrl, flagUrl);
    });

    group('Equatable', () {
      test('supports value equality', () {
        expect(
          const Country(isoCode: isoCode, name: name, flagUrl: flagUrl),
          equals(country),
        );
      });

      test('props are correct', () {
        expect(country.props, equals([isoCode, name, flagUrl]));
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
