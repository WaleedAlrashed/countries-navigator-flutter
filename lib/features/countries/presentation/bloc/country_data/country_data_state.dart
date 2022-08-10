part of 'country_data_bloc.dart';

abstract class CountryDataState extends Equatable {
  const CountryDataState();

  @override
  List<Object> get props => [];
}

class CountryDataInitial extends CountryDataState {}

class CountryProfilesGeneratedState extends CountryDataState {
  final Document countryReport;

  const CountryProfilesGeneratedState({required this.countryReport});

  @override
  List<Object> get props => [countryReport];
}

class ErrorCountryProfileState extends CountryDataState {
  final String message;

  const ErrorCountryProfileState({required this.message});

  @override
  List<Object> get props => [message];
}
