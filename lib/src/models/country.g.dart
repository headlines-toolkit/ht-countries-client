// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Country',
      json,
      ($checkedConvert) {
        final val = Country(
          isoCode: $checkedConvert('iso_code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          flagUrl: $checkedConvert('flag_url', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'isoCode': 'iso_code', 'flagUrl': 'flag_url'},
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'iso_code': instance.isoCode,
      'name': instance.name,
      'flag_url': instance.flagUrl,
    };
