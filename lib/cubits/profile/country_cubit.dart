import 'package:bloc/bloc.dart';
import 'package:blueprint/models/profile/country.dart';
import 'package:blueprint/repos/profile/get_countries_repo.dart';
import 'package:injectable/injectable.dart';

part 'country_state.dart';

@singleton
class CountryCubit extends Cubit<CountryState> {
  final GetCountriesRepo getCountriesRepo;

  CountryCubit(this.getCountriesRepo) : super(CountryStateInitial());

  Future<void> setLoading() async {
    if (state is CountryStateLoaded) return;

    emit(CountryStateLoading());

    try {
      final countries = await getCountriesRepo();

      //TODO remove this comment
      await Future.delayed(const Duration(seconds: 2));

      emit(CountryStateLoaded(countries));
    } on Exception catch (e) {
      emit(CountryStateFailed(e.toString()));
    }
  }
}
