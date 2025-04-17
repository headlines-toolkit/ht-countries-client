// ignore_for_file: lines_longer_than_80_chars

import 'package:ht_countries_client/src/models/models.dart';

/// {@template country_exception}
/// Base class for exceptions related to country data operations.
/// {@endtemplate}
class CountryException implements Exception {
  /// {@macro country_exception}
  const CountryException(this.error, [this.stackTrace]);

  /// The underlying error that occurred.
  final Object error;

  /// The stack trace associated with the error, if available.
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'CountryException: $error';
  }
}

/// {@template country_fetch_failure}
/// Thrown when fetching country data (list or single) fails.
/// {@endtemplate}
class CountryFetchFailure extends CountryException {
  /// {@macro country_fetch_failure}
  const CountryFetchFailure(super.error, [super.stackTrace]);

  @override
  String toString() {
    return 'CountryFetchFailure: $error';
  }
}

/// {@template country_not_found}
/// Thrown when a specific country is not found by its identifier.
/// {@endtemplate}
class CountryNotFound extends CountryException {
  /// {@macro country_not_found}
  const CountryNotFound(super.error, [super.stackTrace]);

  @override
  String toString() {
    return 'CountryNotFound: $error';
  }
}

/// {@template country_create_failure}
/// Thrown when creating a new country record fails.
/// {@endtemplate}
class CountryCreateFailure extends CountryException {
  /// {@macro country_create_failure}
  const CountryCreateFailure(super.error, [super.stackTrace]);

  @override
  String toString() {
    return 'CountryCreateFailure: $error';
  }
}

/// {@template country_update_failure}
/// Thrown when updating an existing country record fails.
/// {@endtemplate}
class CountryUpdateFailure extends CountryException {
  /// {@macro country_update_failure}
  const CountryUpdateFailure(super.error, [super.stackTrace]);

  @override
  String toString() {
    return 'CountryUpdateFailure: $error';
  }
}

/// {@template country_delete_failure}
/// Thrown when deleting a country record fails.
/// {@endtemplate}
class CountryDeleteFailure extends CountryException {
  /// {@macro country_delete_failure}
  const CountryDeleteFailure(super.error, [super.stackTrace]);

  @override
  String toString() {
    return 'CountryDeleteFailure: $error';
  }
}

/// {@template ht_countries_client}
/// An abstract interface for interacting with country data.
///
/// This contract defines the standard CRUD operations for managing countries.
/// Implementations of this class are responsible for handling the actual
/// data fetching and manipulation from a specific source (e.g., API, database).
/// {@endtemplate}
abstract class HtCountriesClient {
  /// Fetches a paginated list of available countries using cursor-based pagination.
  ///
  /// [limit]: The maximum number of countries to return in this page.
  /// [startAfterId]: The unique ID (UUID) of the last country fetched in the
  ///   previous page. If null or omitted, fetches the first page.
  ///
  /// Returns a list of [Country] objects starting after the country with
  /// [startAfterId], up to the specified [limit]. The list might be empty if
  /// no more countries are available after the specified ID.
  ///
  /// {@macro country_fetch_failure}
  /// @throws [CountryFetchFailure] if an error occurs during the fetch operation.
  Future<List<Country>> fetchCountries({
    required int limit,
    String? startAfterId,
  });

  /// Fetches a single country by its unique ISO 3166-1 alpha-2 code.
  ///
  /// [isoCode]: The ISO code of the country to fetch.
  ///
  /// Returns the corresponding [Country] object.
  ///
  /// {@macro country_fetch_failure}
  /// @throws [CountryFetchFailure] if an error occurs during the fetch operation.
  /// {@macro country_not_found}
  /// @throws [CountryNotFound] if no country with the given [isoCode] exists.
  Future<Country> fetchCountry(String isoCode);

  /// Creates a new country record.
  ///
  /// [country]: The [Country] object containing the data for the new record.
  ///
  /// Returns a [Future] that completes when the operation is successful.
  ///
  /// {@macro country_create_failure}
  /// @throws [CountryCreateFailure] if the creation operation fails (e.g., due
  ///   to network issues, validation errors, or duplicate entries if applicable).
  Future<void> createCountry(Country country);

  /// Updates an existing country record.
  ///
  /// [country]: The [Country] object containing the updated data. The `isoCode`
  ///   field is typically used to identify the record to update.
  ///
  /// Returns a [Future] that completes when the operation is successful.
  ///
  /// {@macro country_update_failure}
  /// @throws [CountryUpdateFailure] if the update operation fails (e.g., due
  ///   to network issues or validation errors).
  /// {@macro country_not_found}
  /// @throws [CountryNotFound] if no country with the `isoCode` specified in
  ///   the [country] object exists.
  Future<void> updateCountry(Country country);

  /// Deletes a country record by its unique ISO 3166-1 alpha-2 code.
  ///
  /// [isoCode]: The ISO code of the country to delete.
  ///
  /// Returns a [Future] that completes when the operation is successful.
  ///
  /// {@macro country_delete_failure}
  /// @throws [CountryDeleteFailure] if the deletion operation fails.
  /// {@macro country_not_found}
  /// @throws [CountryNotFound] if no country with the given [isoCode] exists.
  Future<void> deleteCountry(String isoCode);
}
