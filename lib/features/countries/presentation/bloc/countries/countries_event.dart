part of 'countries_bloc.dart';

abstract class CountriesEvent extends Equatable {
  const CountriesEvent();

  @override
  List<Object> get props => [];
}

class GetAllCountriesEvent extends CountriesEvent {}

class RefreshCountriesEvent extends CountriesEvent {}
