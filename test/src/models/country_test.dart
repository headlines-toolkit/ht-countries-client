import 'dart:convert';

import 'package:ht_countries_client/src/models/country.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Country Model', () {
    const uuid = Uuid();
    final testId = uuid.v4();
    const testIsoCode = 'US';
    const testName = 'United States';
    const testFlagUrl = 'https://example.com/us_flag.png';

    final validJsonMap = {
      'id': testId,
      'iso_code': testIsoCode,
      'name': testName,
      'flag_url': testFlagUrl,
    };

    final validJsonMapWithoutId = {
      'iso_code': testIsoCode,
      'name': testName,
      'flag_url': testFlagUrl,
    };

    final validJsonString = jsonEncode(validJsonMap);
    final validJsonStringWithoutId = jsonEncode(validJsonMapWithoutId);

    Country createSubject({
      String? id,
      String isoCode = testIsoCode,
      String name = testName,
      String flagUrl = testFlagUrl,
    }) {
      return Country(
        id: id ?? testId,
        isoCode: isoCode,
        name: name,
        flagUrl: flagUrl,
      );
    }

    group('Constructor', () {
      test('creates instance with provided id', () {
        final country = createSubject(id: testId);
        expect(country.id, testId);
        expect(country.isoCode, testIsoCode);
        expect(country.name, testName);
        expect(country.flagUrl, testFlagUrl);
      });

      test('creates instance with generated id if id is null', () {
        final country = Country(
          isoCode: testIsoCode,
          name: testName,
          flagUrl: testFlagUrl,
          // No id provided
        );
        expect(country.id, isA<String>());
        expect(Uuid.isValidUUID(fromString: country.id), isTrue);
        expect(country.isoCode, testIsoCode);
        expect(country.name, testName);
        expect(country.flagUrl, testFlagUrl);
      });
    });

    group('fromJson', () {
      test('parses correctly from valid JSON map with id', () {
        final country = Country.fromJson(validJsonMap);
        expect(country.id, testId);
        expect(country.isoCode, testIsoCode);
        expect(country.name, testName);
        expect(country.flagUrl, testFlagUrl);
      });

      test(
        'parses correctly from valid JSON map without id (generates new id)',
        () {
          final country = Country.fromJson(validJsonMapWithoutId);
          expect(country.id, isA<String>());
          expect(Uuid.isValidUUID(fromString: country.id), isTrue);
          expect(country.isoCode, testIsoCode);
          expect(country.name, testName);
          expect(country.flagUrl, testFlagUrl);
        },
      );

      test('throws FormatException for missing iso_code', () {
        final invalidJson = {...validJsonMap}..remove('iso_code');
        expect(
          () => Country.fromJson(invalidJson),
          throwsA(
            isA<FormatException>().having(
              (e) => e.message,
              'message',
              contains('Missing required field "iso_code"'),
            ),
          ),
        );
      });

      test('throws FormatException for missing name', () {
        final invalidJson = {...validJsonMap}..remove('name');
        expect(
          () => Country.fromJson(invalidJson),
          throwsA(
            isA<FormatException>().having(
              (e) => e.message,
              'message',
              contains('Missing required field "name"'),
            ),
          ),
        );
      });

      test('throws FormatException for missing flag_url', () {
        final invalidJson = {...validJsonMap}..remove('flag_url');
        expect(
          () => Country.fromJson(invalidJson),
          throwsA(
            isA<FormatException>().having(
              (e) => e.message,
              'message',
              contains('Missing required field "flag_url"'),
            ),
          ),
        );
      });

      // Note: The current implementation uses `as String?` which would throw
      // a TypeError at runtime if the type is wrong, not a FormatException
      // during the checks.
      //Testing for wrong types would require more robust checks.
      test('throws TypeError for wrong type (iso_code)', () {
        final invalidJson = {...validJsonMap, 'iso_code': 123};
        expect(() => Country.fromJson(invalidJson), throwsA(isA<TypeError>()));
      });
    });

    group('fromJsonString', () {
      test('parses correctly from valid JSON string with id', () {
        final country = Country.fromJsonString(validJsonString);
        expect(country.id, testId);
        expect(country.isoCode, testIsoCode);
        expect(country.name, testName);
        expect(country.flagUrl, testFlagUrl);
      });

      test('parses correctly from valid JSON string without id', () {
        final country = Country.fromJsonString(validJsonStringWithoutId);
        expect(country.id, isA<String>());
        expect(Uuid.isValidUUID(fromString: country.id), isTrue);
        expect(country.isoCode, testIsoCode);
        expect(country.name, testName);
        expect(country.flagUrl, testFlagUrl);
      });

      test('throws FormatException for invalid JSON string', () {
        const invalidJsonString = '{"invalid json';
        expect(
          () => Country.fromJsonString(invalidJsonString),
          // Check for any FormatException, as jsonDecode throws its own
          // specific FormatException for syntax errors before our catch block.
          throwsA(isA<FormatException>()),
        );
      });

      test('re-throws FormatException from fromJson for missing field', () {
        final invalidJson = {...validJsonMap}..remove('name');
        final invalidJsonString = jsonEncode(invalidJson);
        expect(
          () => Country.fromJsonString(invalidJsonString),
          throwsA(
            isA<FormatException>().having(
              (e) => e.message,
              'message',
              contains('Missing required field "name"'),
            ),
          ),
        );
      });
    });

    group('toJson', () {
      test('converts correctly to JSON map', () {
        final country = createSubject();
        final json = country.toJson();
        expect(json, equals(validJsonMap));
      });
    });

    group('toJsonString', () {
      test('converts correctly to JSON string', () {
        final country = createSubject();
        final jsonString = country.toJsonString();
        // Decode and re-encode to handle potential key order differences
        expect(jsonDecode(jsonString), equals(jsonDecode(validJsonString)));
      });
    });

    group('Equatable', () {
      test('instances with same properties are equal', () {
        final country1 = createSubject(id: testId);
        final country2 = createSubject(id: testId);
        expect(country1, equals(country2));
      });

      test('instances with different ids are not equal', () {
        final country1 = createSubject(id: uuid.v4());
        final country2 = createSubject(id: uuid.v4());
        expect(country1, isNot(equals(country2)));
      });

      test('instances with different isoCodes are not equal', () {
        final country1 = createSubject();
        final country2 = createSubject(isoCode: 'GB');
        expect(country1, isNot(equals(country2)));
      });

      test('instances with different names are not equal', () {
        final country1 = createSubject(name: 'USA');
        final country2 = createSubject(name: 'UK');
        expect(country1, isNot(equals(country2)));
      });

      test('instances with different flagUrls are not equal', () {
        final country1 = createSubject(flagUrl: 'url1');
        final country2 = createSubject(flagUrl: 'url2');
        expect(country1, isNot(equals(country2)));
      });

      test('props list is correct', () {
        final country = createSubject();
        expect(
          country.props,
          equals([testId, testIsoCode, testName, testFlagUrl]),
        );
      });
    });
  });
}
