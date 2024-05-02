import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';
part 'country.g.dart';

@freezed
class Country with _$Country {
  const factory Country({
    required String name,
    @JsonKey(name: 'iso_code') required String isoCode,
    @JsonKey(name: 'phone_code') required String phoneCode,
    required String mask,
    @JsonKey(name: 'min_length') required int minLength,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}
