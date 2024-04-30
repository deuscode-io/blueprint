import 'package:bloc/bloc.dart';
import 'package:blueprint/blocs/profile/profile_event.dart';
import 'package:blueprint/blocs/profile/profile_state.dart';
import 'package:blueprint/utils/validators/library_validators.dart';
import 'package:injectable/injectable.dart';

@singleton
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirstNameValidator firstNameValidator;
  final LastNameValidator lastNameValidator;
  final AppEmailValidator appEmailValidator;

  ProfileBloc(
    this.firstNameValidator,
    this.lastNameValidator,
    this.appEmailValidator,
  ) : super(ProfileState()) {
    on<UpdateFirstNameText>((event, emit) {
      emit(
        state.copyWith(
          firstName: event.text,
          firstNameError: firstNameValidator.call(name: event.text, hasFocus: true),
        ),
      );
    });

    on<UpdateFirstNameFocus>((event, emit) {
      emit(
        state.copyWith(
          firstNameError: firstNameValidator.call(name: state.firstName, hasFocus: event.hasFocus),
        ),
      );
    });

    on<UpdateLastNameText>((event, emit) async {
      emit(
        state.copyWith(
          lastName: event.text,
          lastNameError: lastNameValidator.call(name: event.text, hasFocus: true),
        ),
      );
    });

    on<UpdateLastNameFocus>((event, emit) {
      emit(
        state.copyWith(
          lastNameError: lastNameValidator.call(name: state.lastName, hasFocus: event.hasFocus),
        ),
      );
    });

    on<UpdateEmailText>((event, emit) async {
      emit(
        state.copyWith(
          email: event.text,
          emailError: appEmailValidator.call(email: event.text, hasFocus: true),
        ),
      );
    });

    on<UpdateEmailFocus>((event, emit) {
      emit(
        state.copyWith(
          emailError: appEmailValidator.call(email: state.email, hasFocus: event.hasFocus),
        ),
      );
    });

    on<UpdateCountry>((event, emit) {});

    on<UpdatePhoneNumberText>((event, emit) {});

    on<UpdatePhoneNumberFocus>((event, emit) {});

    on<UpdateButtonPressed>((event, emit) async {
      emit(state.copyWith(isUpdating: true));
      await Future.delayed(const Duration(seconds: 4));
      emit(state.copyWith(isUpdating: false));
    });

    on<ShowRequiredFields>((event, emit) async {
      emit(
        state.copyWith(
          firstNameError: firstNameValidator.call(name: state.firstName, isPressed: true),
          lastNameError: lastNameValidator.call(name: state.lastName, isPressed: true),
          emailError: appEmailValidator.call(email: state.email, isPressed: true),
        ),
      );
    });
  }
}
