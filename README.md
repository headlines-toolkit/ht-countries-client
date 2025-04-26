# ht_countries_client

![coverage: percentage](https://img.shields.io/badge/coverage-97-green)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis) 
[![License: PolyForm Free Trial](https://img.shields.io/badge/License-PolyForm%20Free%20Trial-blue)](https://polyformproject.org/licenses/free-trial/1.0.0)

> **Note:** This package is being archived. Please use the successor package [`ht-data-client`](https://github.com/headlines-toolkit/ht-data-client) instead.

A Dart client interface package for managing news countries.

## Description

This package provides an abstract interface (`HtCountriesClient`) for fetching, creating, updating, and deleting country information. It's designed to be implemented by specific data source clients (e.g., API clients, database clients).

The client supports cursor-based pagination for fetching countries efficiently.

## Installation

This package is hosted on GitHub and is not intended for publication on pub.dev. To use it in your project, add it as a Git dependency in your `pubspec.yaml`:

```yaml
dependencies:
  ht_countries_client:
    git:
      url: https://github.com/headlines-toolkit/ht-countries-client.git
      # Optionally specify a ref (branch, tag, commit hash):
      # ref: main
```

Then run `flutter pub get` or `dart pub get`.

## Usage

Implement the `HtCountriesClient` interface with your specific data fetching logic.

```dart
import 'package:ht_countries_client/ht_countries_client.dart';

// Example implementation (replace with your actual client)
class MyApiCountriesClient implements HtCountriesClient {
  // ... implementation details for your API ...

  @override
  Future<List<Country>> fetchCountries({required int limit, String? startAfterId}) async {
    // Your logic to call the API with limit and startAfterId
    print('Fetching countries: limit=$limit, startAfterId=$startAfterId');
    // Example: return dummy data
    if (startAfterId == null) {
      return List.generate(limit, (i) => Country(
        isoCode: 'C${i+1}',
        name: 'Country ${i+1}',
        flagUrl: 'url/c${i+1}.svg',
      ));
    } else {
      // Logic to fetch next page based on startAfterId
      return []; // Return empty list if no more data
    }
  }

  @override
  Future<Country> fetchCountry(String isoCode) async {
    // ... implementation ...
    throw UnimplementedError();
  }

  @override
  Future<void> createCountry(Country country) async {
    // ... implementation ...
    throw UnimplementedError();
  }

  @override
  Future<void> updateCountry(Country country) async {
    // ... implementation ...
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCountry(String isoCode) async {
    // ... implementation ...
    throw UnimplementedError();
  }
}

void main() async {
  final client = MyApiCountriesClient();

  try {
    // Fetch the first page (e.g., 10 countries)
    List<Country> firstPage = await client.fetchCountries(limit: 10);
    print('First page: ${firstPage.length} countries');

    if (firstPage.isNotEmpty) {
      // Fetch the next page starting after the last country of the first page
      String lastId = firstPage.last.id;
      List<Country> secondPage = await client.fetchCountries(limit: 10, startAfterId: lastId);
      print('Second page: ${secondPage.length} countries');
    }

  } on CountryFetchFailure catch (e) {
    print('Error fetching countries: $e');
  }
}

```

## Models

*   **`Country`**: Represents a country with `id` (UUID), `isoCode`, `name`, and `flagUrl`.

## Exceptions

The client defines specific exceptions for different error scenarios (e.g., `CountryFetchFailure`, `CountryNotFound`). See `lib/src/exceptions.dart`.

## Testing

This package includes unit tests. Run them using:

```bash
dart test
```

## License

This package is licensed under the [PolyForm Free Trial](LICENSE). See the [LICENSE](LICENSE) file for details.
