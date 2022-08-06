part of 'countries_bloc.dart';

abstract class CountriesState extends Equatable {
  const CountriesState();

  @override
  List<Object> get props => [];
}

class CountriesInitial extends CountriesState {}

class LoadingCountriesState extends CountriesState {}

class LoadedCountriesState extends CountriesState {
  final List<Country> countries;

  const LoadedCountriesState({required this.countries});

  @override
  List<Object> get props => [countries];
}

class ErrorCountriesState extends CountriesState {
  final String message;

  const ErrorCountriesState({required this.message});

  @override
  List<Object> get props => [message];
}
