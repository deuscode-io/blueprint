sealed class ProfileEvent {}

class UpdateFirstNameText extends ProfileEvent {
  final String text;

  UpdateFirstNameText(this.text);
}

class UpdateFirstNameFocus extends ProfileEvent {
  final bool hasFocus;

  UpdateFirstNameFocus(this.hasFocus);
}

class UpdateLastNameText extends ProfileEvent {
  final String text;

  UpdateLastNameText(this.text);
}

class UpdateLastNameFocus extends ProfileEvent {
  final bool hasFocus;

  UpdateLastNameFocus(this.hasFocus);
}

class UpdateEmailText extends ProfileEvent {
  final String text;

  UpdateEmailText(this.text);
}

class UpdateEmailFocus extends ProfileEvent {
  final bool hasFocus;

  UpdateEmailFocus(this.hasFocus);
}

class UpdateButtonPressed extends ProfileEvent {

  UpdateButtonPressed();
}

class ShowRequiredFields extends ProfileEvent {

  ShowRequiredFields();
}
