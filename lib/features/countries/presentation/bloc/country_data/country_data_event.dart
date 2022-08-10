part of 'country_data_bloc.dart';

abstract class CountryDataEvent extends Equatable {
  const CountryDataEvent();

  @override
  List<Object> get props => [];
}

class GenerateCountryProfileEvent extends CountryDataEvent {
  final Country country;

  const GenerateCountryProfileEvent({required this.country});

  @override
  List<Object> get props => [country];
}
