import 'package:blueprint/features/countries/models/country.dart';

sealed class ProfileEvent {}

class InitState implements ProfileEvent {}

class UpdateFirstName implements ProfileEvent {
  final String firstName;

  UpdateFirstName(this.firstName);
}

class UpdateFirstNameFocus implements ProfileEvent {
  final bool hasFocus;

  UpdateFirstNameFocus(this.hasFocus);
}

class UpdateLastName implements ProfileEvent {
  final String lastName;

  UpdateLastName(this.lastName);
}

class UpdateLastNameFocus implements ProfileEvent {
  final bool hasFocus;

  UpdateLastNameFocus(this.hasFocus);
}

class UpdateEmail implements ProfileEvent {
  final String email;

  UpdateEmail(this.email);
}

class UpdateEmailFocus implements ProfileEvent {
  final bool hasFocus;

  UpdateEmailFocus(this.hasFocus);
}

class UpdateCountry implements ProfileEvent {
  final Country country;

  UpdateCountry(this.country);
}

class UpdatePhoneNumber implements ProfileEvent {
  final String phoneNumber;
  final bool hasFocus;

  UpdatePhoneNumber(this.phoneNumber, this.hasFocus);
}

class UpdatePhoneNumberFocus implements ProfileEvent {
  final bool hasFocus;

  UpdatePhoneNumberFocus(this.hasFocus);
}

class UpdateButtonPressed implements ProfileEvent {
  UpdateButtonPressed();
}

class ShowRequiredFields implements ProfileEvent {
  ShowRequiredFields();
}
