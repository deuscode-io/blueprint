part of 'country_cubit.dart';

sealed class CountryState {}

final class CountryStateInitial extends CountryState {}

final class CountryStateLoading extends CountryState {}

final class CountryStateLoaded extends CountryState {
  final List<Country> countries;

  CountryStateLoaded(this.countries);
}

final class CountryStateFailed extends CountryState {
  final String failure;

  CountryStateFailed(this.failure);
}
