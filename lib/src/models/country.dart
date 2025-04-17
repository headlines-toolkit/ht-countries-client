import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// {@template country}
/// Represents a country with its essential details.
///
/// Used typically in contexts like selecting a country for news headlines
/// or user profile settings.
/// {@endtemplate}
class Country extends Equatable {
  /// {@macro country}
  Country({
    required this.isoCode,
    required this.name,
    required this.flagUrl,
    String? id,
  }) : id = id ?? const Uuid().v4();

  /// Creates a Country instance from a JSON map.
  ///
  /// Throws a [FormatException] if the JSON is invalid or missing
  /// required fields.
  factory Country.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String?;
    final isoCode = json['iso_code'] as String?;
    final name = json['name'] as String?;
    final flagUrl = json['flag_url'] as String?;

    if (isoCode == null) {
      throw const FormatException(
        'Missing required field "iso_code" in Country JSON.',
      );
    }
    if (name == null) {
      throw const FormatException(
        'Missing required field "name" in Country JSON.',
      );
    }
    if (flagUrl == null) {
      throw const FormatException(
        'Missing required field "flag_url" in Country JSON.',
      );
    }

    return Country(
      id: id, // Let the constructor handle UUID generation if null
      isoCode: isoCode,
      name: name,
      flagUrl: flagUrl,
    );
  }

  /// Creates a Country instance from a JSON string.
  ///
  /// Throws a [FormatException] if the JSON string is invalid.
  factory Country.fromJsonString(String jsonString) {
    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return Country.fromJson(jsonMap);
    } on FormatException {
      rethrow; // Re-throw specific format exceptions from Country.fromJson
    } catch (e) {
      // Catch potential errors from jsonDecode
      throw FormatException('Invalid JSON string for Country: $e');
    }
  }

  /// A unique identifier for the country instance, typically a UUID.
  final String id;

  /// The unique ISO 3166-1 alpha-2 code for the country (e.g., "US", "GB").
  final String isoCode;

  /// The common name of the country (e.g., "United States", "United Kingdom").
  final String name;

  /// The URL pointing to an image of the country's flag.
  final String flagUrl;

  /// Converts this Country instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {'id': id, 'iso_code': isoCode, 'name': name, 'flag_url': flagUrl};
  }

  /// Converts this Country instance into a JSON string.
  String toJsonString() => jsonEncode(toJson());

  @override
  List<Object> get props => [id, isoCode, name, flagUrl];
}
