import 'package:copy_with_extension/copy_with_extension.dart';

part 'profile_state.g.dart';

@CopyWith(copyWithNull: true)
class ProfileState {
  final String firstName;
  final String lastName;
  final String email;
  final String? firstNameError;
  final String? lastNameError;
  final String? emailError;
  final bool isUpdating;

  ProfileState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.isUpdating = false,
    this.firstNameError,
    this.lastNameError,
    this.emailError,
  });

  bool get canUpdate {
    return firstName.isNotEmpty &&
        firstNameError == null &&
        lastName.isNotEmpty &&
        lastNameError == null &&
        email.isNotEmpty &&
        emailError == null;
  }
}
