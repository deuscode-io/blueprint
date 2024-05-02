import 'package:bloc/bloc.dart';
import 'package:blueprint/features/countries/repos/get_countries_repo.dart';
import 'package:blueprint/features/profile/blocs/profile_event.dart';
import 'package:blueprint/features/profile/blocs/profile_state.dart';
import 'package:blueprint/features/profile/repos/get_profile_repo.dart';
import 'package:blueprint/widgets/input_fields/country_phone/country_phone_validator.dart';
import 'package:blueprint/widgets/input_fields/email/app_email_validator.dart';
import 'package:blueprint/widgets/input_fields/name/validators/first_name_validator.dart';
import 'package:blueprint/widgets/input_fields/name/validators/last_name_validator.dart';
import 'package:injectable/injectable.dart';

@singleton
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirstNameValidator firstNameValidator;
  final LastNameValidator lastNameValidator;
  final AppEmailValidator appEmailValidator;
  final CountryPhoneValidator countryPhoneValidator;
  final GetCountriesRepo getCountriesRepo;
  final GetProfileRepo getProfileRepo;

  ProfileStateLoaded get loadedState => state as ProfileStateLoaded;

  ProfileBloc(
    this.firstNameValidator,
    this.lastNameValidator,
    this.appEmailValidator,
    this.countryPhoneValidator,
    this.getCountriesRepo,
    this.getProfileRepo,
  ) : super(ProfileStateInitial()) {
    on<InitState>((event, emit) async {
      try {
        emit(ProfileStateLoading());

        final profile = await getProfileRepo();
        final countries = await getCountriesRepo();

        //TODO remove next line
        await Future.delayed(const Duration(seconds: 3));

        emit(
          ProfileStateLoaded(
            countries: countries,
            lastSavedProfile: profile,
            firstName: profile.firstName,
            lastName: profile.lastName,
            email: profile.email,
            country: countries.firstWhere(
              (c) => c.isoCode == profile.icoCountryCode,
              orElse: () => countries.first,
            ),
            phoneNumber: profile.phoneNumber,
          ),
        );
      } on Exception catch (e) {
        emit(ProfileStateFailed(e.toString()));
      }
    });

    on<UpdateFirstName>((event, emit) {
      emit(
        loadedState.copyWith(
          firstName: event.firstName,
          firstNameError:
              firstNameValidator.call(name: event.firstName, hasFocus: true),
        ),
      );
    });

    on<UpdateFirstNameFocus>((event, emit) {
      emit(
        loadedState.copyWith(
          firstNameError: firstNameValidator.call(
            name: loadedState.firstName,
            hasFocus: event.hasFocus,
          ),
        ),
      );
    });

    on<UpdateLastName>((event, emit) async {
      emit(
        loadedState.copyWith(
          lastName: event.lastName,
          lastNameError:
              lastNameValidator.call(name: event.lastName, hasFocus: true),
        ),
      );
    });

    on<UpdateLastNameFocus>((event, emit) {
      emit(
        loadedState.copyWith(
          lastNameError: lastNameValidator.call(
            name: loadedState.lastName,
            hasFocus: event.hasFocus,
          ),
        ),
      );
    });

    on<UpdateEmail>((event, emit) async {
      emit(
        loadedState.copyWith(
          email: event.email,
          emailError:
              appEmailValidator.call(email: event.email, hasFocus: true),
        ),
      );
    });

    on<UpdateEmailFocus>((event, emit) {
      emit(
        loadedState.copyWith(
          emailError: appEmailValidator.call(
            email: loadedState.email,
            hasFocus: event.hasFocus,
          ),
        ),
      );
    });

    on<UpdateCountry>((event, emit) {
      emit(
        loadedState.copyWith(
          country: event.country,
          phoneNumberError: countryPhoneValidator(
            phone: loadedState.phoneNumber,
            minPhoneLength: event.country.minLength,
          ),
        ),
      );
    });

    on<UpdatePhoneNumber>((event, emit) {
      emit(
        loadedState.copyWith(
          phoneNumber: event.phoneNumber,
          phoneNumberError: countryPhoneValidator(
            phone: event.phoneNumber,
            minPhoneLength: loadedState.country.minLength,
            hasFocus: event.hasFocus,
          ),
        ),
      );
    });

    on<UpdatePhoneNumberFocus>((event, emit) {
      emit(
        loadedState.copyWith(
          phoneNumberError: countryPhoneValidator(
            phone: loadedState.phoneNumber,
            minPhoneLength: loadedState.country.minLength,
            hasFocus: event.hasFocus,
          ),
        ),
      );
    });

    on<UpdateButtonPressed>((event, emit) async {
      emit(loadedState.copyWith(isUpdating: true));
      await Future.delayed(const Duration(seconds: 4));
      emit(loadedState.copyWith(isUpdating: false));
    });

    on<ShowRequiredFields>((event, emit) async {
      emit(
        loadedState.copyWith(
          firstNameError: firstNameValidator.call(
            name: loadedState.firstName,
            isPressed: true,
          ),
          lastNameError: lastNameValidator.call(
            name: loadedState.lastName,
            isPressed: true,
          ),
          emailError: appEmailValidator.call(
            email: loadedState.email,
            isPressed: true,
          ),
          phoneNumberError: countryPhoneValidator.call(
            phone: loadedState.phoneNumber,
            isPressed: true,
            minPhoneLength: loadedState.country.minLength,
          ),
        ),
      );
    });
  }
}
