import 'package:bloc/bloc.dart' show Bloc;
import 'package:countries_navigator/core/constants/failures_strings.dart';
import 'package:countries_navigator/core/errors/faliures.dart';
import 'package:countries_navigator/features/countries/domain/entites/country.dart';
import 'package:countries_navigator/features/countries/domain/usecases/get_all_countries.dart';
import 'package:dartz/dartz.dart' show Either;
import 'package:equatable/equatable.dart';

part 'countries_event.dart';
part 'countries_state.dart';

class CountriesBloc extends Bloc<CountriesEvent, CountriesState> {
  final GetAllCountriesUsecase getAllCountries;

  CountriesBloc({required this.getAllCountries}) : super(CountriesInitial()) {
    on<CountriesEvent>(
      (event, emit) async {
        if (event is GetAllCountriesEvent) {
          emit(LoadingCountriesState());

          final failureOrCountries = await getAllCountries();

          emit(_mapFailureOrCountriesToState(failureOrCountries));
        } else if (event is RefreshCountriesEvent) {
          emit(LoadingCountriesState());

          final failureOrCountries = await getAllCountries();

          emit(_mapFailureOrCountriesToState(failureOrCountries));
        }
      },
    );
  }

  CountriesState _mapFailureOrCountriesToState(
      Either<Failure, List<Country>> either) {
    return either.fold(
      (failure) => ErrorCountriesState(message: _mapFailureToMessage(failure)),
      (countries) => LoadedCountriesState(countries: countries),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return FailureStrings.serverFailure;
      case EmptyCacheFailure:
        return FailureStrings.emptyCacheFailure;
      case OfflineFailure:
        return FailureStrings.offlineFailure;
      default:
        return FailureStrings.genericFailure;
    }
  }
}
