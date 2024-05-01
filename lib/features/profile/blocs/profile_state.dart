import 'package:blueprint/features/countries/models/country.dart';
import 'package:blueprint/features/profile/models/profile.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'profile_state.g.dart';

sealed class ProfileState {}

final class ProfileStateInitial implements ProfileState {}

final class ProfileStateLoading implements ProfileState {}

final class ProfileStateFailed implements ProfileState {
  final String failure;

  ProfileStateFailed(this.failure);
}

@CopyWith(copyWithNull: true)
final class ProfileStateLoaded implements ProfileState {
  final List<Country> countries;
  final Profile lastSavedProfile;
  final String firstName;
  final String lastName;
  final String email;
  final Country? country;
  final String phoneNumber;
  final String? firstNameError;
  final String? lastNameError;
  final String? emailError;
  final String? countryCodeError;
  final String? phoneNumberError;
  final bool isUpdating;

  ProfileStateLoaded({
    required this.countries,
    required this.lastSavedProfile,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.country,
    required this.phoneNumber,
    this.firstNameError,
    this.lastNameError,
    this.emailError,
    this.countryCodeError,
    this.phoneNumberError,
    this.isUpdating = false,
  });

  bool get canUpdate {
    return firstName.isNotEmpty &&
        firstNameError == null &&
        lastName.isNotEmpty &&
        lastNameError == null &&
        email.isNotEmpty &&
        emailError == null &&
        country != null &&
        countryCodeError == null &&
        phoneNumber.isNotEmpty &&
        phoneNumberError == null;
  }
}
