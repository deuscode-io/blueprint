import 'package:copy_with_extension/copy_with_extension.dart';

part 'profile_state.g.dart';

@CopyWith(copyWithNull: true)
class ProfileState {
  final String firstName;
  final String lastName;
  final String email;
  final String countryCode;
  final String phoneNumber;
  final String? firstNameError;
  final String? lastNameError;
  final String? emailError;
  final String? countryCodeError;
  final String? phoneNumberError;
  final bool isUpdating;

  ProfileState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.countryCode = '',
    this.phoneNumber = '',
    this.isUpdating = false,
    this.firstNameError,
    this.lastNameError,
    this.emailError,
    this.countryCodeError,
    this.phoneNumberError,
  });

  bool get canUpdate {
    return firstName.isNotEmpty &&
        firstNameError == null &&
        lastName.isNotEmpty &&
        lastNameError == null &&
        email.isNotEmpty &&
        emailError == null &&
        countryCode.isNotEmpty &&
        countryCodeError == null &&
        phoneNumber.isNotEmpty &&
        phoneNumberError == null;
  }
}
