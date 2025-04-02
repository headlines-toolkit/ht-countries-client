import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

/// {@template country}
/// Represents a country with its essential details.
///
/// Used typically in contexts like selecting a country for news headlines
/// or user profile settings.
/// {@endtemplate}
@JsonSerializable(checked: true)
class Country extends Equatable {
  /// {@macro country}
  const Country({
    required this.isoCode,
    required this.name,
    required this.flagUrl,
  });

  /// Creates a Country instance from a JSON map.
  ///
  /// Handles potential snake_case keys from APIs.
  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  /// The unique ISO 3166-1 alpha-2 code for the country (e.g., "US", "GB").
  @JsonKey(name: 'iso_code')
  final String isoCode;

  /// The common name of the country (e.g., "United States", "United Kingdom").
  final String name;

  /// The URL pointing to an image of the country's flag.
  @JsonKey(name: 'flag_url')
  final String flagUrl;

  /// Converts this Country instance into a JSON map.
  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  List<Object> get props => [isoCode, name, flagUrl];
}
