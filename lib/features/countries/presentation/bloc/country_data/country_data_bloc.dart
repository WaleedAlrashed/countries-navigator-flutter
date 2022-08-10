import 'package:bloc/bloc.dart';
import 'package:countries_navigator/core/constants/failures_strings.dart';
import 'package:countries_navigator/core/errors/faliures.dart';
import 'package:countries_navigator/features/countries/domain/entites/country.dart';
import 'package:countries_navigator/features/countries/domain/usecases/generate_country_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:pdf/widgets.dart';

part 'country_data_event.dart';
part 'country_data_state.dart';

class CountryDataBloc extends Bloc<CountryDataEvent, CountryDataState> {
  final GenerateCountryProfileUsecase generateCountryProfile;
  CountryDataBloc({required this.generateCountryProfile})
      : super(CountryDataInitial()) {
    on<CountryDataEvent>((event, emit) {
      if (event is GenerateCountryProfileEvent) {
        emit(CountryDataInitial());

        final failureOrDocument = generateCountryProfile.call(event.country);

        emit(_mapFailureOrCountryReportToState(failureOrDocument));
      }
    });
  }
}

///
/// Get Country Profile
///
CountryDataState _mapFailureOrCountryReportToState(
    Either<Failure, Document> either) {
  return either.fold(
    (failure) =>
        ErrorCountryProfileState(message: _mapFailureToMessage(failure)),
    (document) => CountryProfilesGeneratedState(countryReport: document),
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
