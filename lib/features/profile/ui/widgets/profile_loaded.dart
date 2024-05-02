import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/features/profile/blocs/profile_bloc.dart';
import 'package:blueprint/features/profile/blocs/profile_event.dart';
import 'package:blueprint/features/profile/blocs/profile_state.dart';
import 'package:blueprint/widgets/buttons/app_elevated_button.dart';
import 'package:blueprint/widgets/input_fields/country_phone/country_code_field.dart';
import 'package:blueprint/widgets/input_fields/country_phone/phone_number_field.dart';
import 'package:blueprint/widgets/input_fields/email/email_field.dart';
import 'package:blueprint/widgets/input_fields/name/name_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/mixins/library_mixins.dart';

class ProfileLoaded extends StatefulWidget {
  const ProfileLoaded({super.key});

  @override
  State<ProfileLoaded> createState() => _ProfileLoadedState();
}

class _ProfileLoadedState extends State<ProfileLoaded> with TextEditingControllersMixin, FocusNodesMixin {
  final ProfileBloc _profileBloc = Injector.get();

  ProfileStateLoaded get _state => _profileBloc.loadedState;

  @override
  void initState() {
    super.initState();
    firstNameController.text = _state.firstName;
    lastNameController.text = _state.lastName;
    emailController.text = _state.email;
    countryCodeController.text = _state.country.phoneCode;
    phoneNumberController.text = _state.phoneNumber;

    firstNameFocusNode.addListener(() {
      _profileBloc.add(UpdateFirstNameFocus(firstNameFocusNode.hasFocus));
    });

    lastNameFocusNode.addListener(() {
      _profileBloc.add(UpdateLastNameFocus(lastNameFocusNode.hasFocus));
    });

    emailFocusNode.addListener(() {
      _profileBloc.add(UpdateEmailFocus(emailFocusNode.hasFocus));
    });

    phoneNumberFocusNode.addListener(() {
      _profileBloc.add(UpdatePhoneNumberFocus(phoneNumberFocusNode.hasFocus));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: NameField.firstName(
                controller: firstNameController,
                focusNode: firstNameFocusNode,
                onChanged: (text) => _profileBloc.add(UpdateFirstName(text)),
                errorText: _state.firstNameError,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: NameField.lastName(
                controller: lastNameController,
                focusNode: lastNameFocusNode,
                onChanged: (text) => _profileBloc.add(UpdateLastName(text)),
                errorText: _state.lastNameError,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: EmailField(
                controller: emailController,
                focusNode: emailFocusNode,
                onChanged: (text) => _profileBloc.add(UpdateEmail(text)),
                errorText: _state.emailError,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 50,
                    child: CountryCodeField(
                      controller: countryCodeController,
                      onChanged: (country) => _profileBloc.add(UpdateCountry(country)),
                      errorText: _state.phoneNumberError == null ? null : ' ',
                      country: _state.country,
                      countries: _state.countries,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 100,
                    child: PhoneNumberField(
                      controller: phoneNumberController,
                      focusNode: phoneNumberFocusNode,
                      onChanged: (text) => _profileBloc.add(
                        UpdatePhoneNumber(text, phoneNumberFocusNode.hasFocus),
                      ),
                      errorText: _state.phoneNumberError,
                      initialPhoneNumber: phoneNumberController.text,
                      country: _state.country,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
              child: AppElevatedButton.allWidth(
                onPressed: () {
                  if (_state.canUpdate) {
                    _profileBloc.add(UpdateButtonPressed());
                  } else {
                    _profileBloc.add(ShowRequiredFields());
                  }
                },
                label: 'Update profile',
                buttonState: _state.isUpdating ? ButtonState.busy : ButtonState.enabled,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant ProfileLoaded oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
}
