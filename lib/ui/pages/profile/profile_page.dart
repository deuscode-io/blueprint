import 'package:blueprint/actions/authentication/set_auth_token_action.dart';
import 'package:blueprint/blocs/profile/profile_bloc.dart';
import 'package:blueprint/blocs/profile/profile_event.dart';
import 'package:blueprint/blocs/profile/profile_state.dart';
import 'package:blueprint/core/DI/injector.dart';
import 'package:blueprint/cubits/profile/country_cubit.dart';
import 'package:blueprint/ui/widgets/buttons/app_elevated_button.dart';
import 'package:blueprint/ui/widgets/indicators/three_dots_indicator.dart';
import 'package:blueprint/ui/widgets/input_fields/country_code_field.dart';
import 'package:blueprint/ui/widgets/input_fields/email_field.dart';
import 'package:blueprint/ui/widgets/input_fields/name_field.dart';
import 'package:blueprint/ui/widgets/input_fields/phone_number_field.dart';
import 'package:blueprint/utils/mixins/library_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TextEditingControllersMixin, FocusNodesMixin {
  final SetAuthTokenAction _setAuthTokenAction = Injector.get();
  final ProfileBloc _profileBloc = Injector.get();
  final CountryCubit _countryCubit = Injector.get();

  @override
  void initState() {
    super.initState();
    _countryCubit.setLoading();

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
    return BlocBuilder<CountryCubit, CountryState>(
      builder: (context, countryState) {
        if (countryState is CountryStateFailed) {
          return Center(
            child: AppElevatedButton(
              onPressed: _countryCubit.setLoading,
              label: 'Reload',
            ),
          );
        }

        if (countryState is! CountryStateLoaded) {
          return const Center(child: ThreeDotsIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: NameField.firstName(
                        controller: firstNameController,
                        focusNode: firstNameFocusNode,
                        onChanged: (text) => _profileBloc.add(UpdateFirstNameText(text)),
                        errorText: state.firstNameError,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: NameField.lastName(
                        controller: lastNameController,
                        focusNode: lastNameFocusNode,
                        onChanged: (text) => _profileBloc.add(UpdateLastNameText(text)),
                        errorText: state.lastNameError,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: EmailField(
                        controller: emailController,
                        focusNode: emailFocusNode,
                        onChanged: (text) => _profileBloc.add(UpdateEmailText(text)),
                        errorText: state.emailError,
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
                              onChanged: (text) => _profileBloc.add(UpdateCountry(text)),
                              errorText: state.countryCodeError,
                              country: state.country,
                              countries: countryState.countries,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 100,
                            child: PhoneNumberField(
                              controller: phoneNumberController,
                              focusNode: phoneNumberFocusNode,
                              onChanged: (text) => _profileBloc.add(UpdatePhoneNumberText(text)),
                              errorText: state.phoneNumberError,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 16, top: 32),
                      child: AppElevatedButton(
                        onPressed: () {
                          if (state.canUpdate) {
                            _profileBloc.add(UpdateButtonPressed());
                          } else {
                            _profileBloc.add(ShowRequiredFields());
                          }
                        },
                        label: 'Update profile',
                        buttonState: state.isUpdating ? ButtonState.busy : ButtonState.enabled,
                      ),
                    ),
                  ],
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 16),
              child: AppElevatedButton(
                label: 'Log out',
                onPressed: () {
                  _setAuthTokenAction.call('');
                  context.go('/');
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
