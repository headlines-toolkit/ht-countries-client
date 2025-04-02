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
