import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    required String email,
    @JsonKey(name: 'iso_country_code') required String icoCountryCode,
    @JsonKey(name: 'phone_number') required String phoneNumber,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  factory Profile.mock() {
    return const Profile(
      id: 'id',
      firstName: 'Garry',
      lastName: 'Bush',
      email: 'garry_bush@gmail.com',
      icoCountryCode: 'FR',
      phoneNumber: '987654321',
    );
  }
}
