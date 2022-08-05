import 'package:countries_navigator/features/countries/data/models/country_model.dart';
import 'package:equatable/equatable.dart';

class Country extends Equatable {
  Name? name;
  List<String>? tld;
  String? cca2;
  String? cca3;
  bool? independent;
  String? status;
  bool? unMember;
  Currencies? currencies;
  Idd? idd;
  List<String>? capital;
  List<String>? altSpellings;
  String? region;
  String? subregion;
  Languages? languages;
  Translations? translations;
  List<double>? latlng;
  bool? landlocked;
  List<String>? borders;
  double? area;
  String? flag;
  Maps? maps;
  dynamic population;
  List<String>? timezones;
  List<String>? continents;
  Flags? flags;
  CoatOfArms? coatOfArms;
  String? startOfWeek;
  String? error;

  Country({
    this.name,
    this.tld,
    this.cca2,
    this.cca3,
    this.independent,
    this.status,
    this.unMember,
    this.currencies,
    this.idd,
    this.capital,
    this.altSpellings,
    this.region,
    this.subregion,
    this.languages,
    this.translations,
    this.latlng,
    this.landlocked,
    this.borders,
    this.area,
    this.flag,
    this.maps,
    this.population,
    this.timezones,
    this.continents,
    this.flags,
    this.coatOfArms,
    this.startOfWeek,
  });

  @override
  List<Object?> get props => [
        name,
        tld,
        cca2,
        cca3,
        independent,
        status,
        unMember,
        currencies,
        idd,
        capital,
        altSpellings,
        region,
        subregion,
        languages,
        translations,
        latlng,
        landlocked,
        borders,
        area,
        flag,
        maps,
        population,
        timezones,
        continents,
        flags,
        coatOfArms,
        startOfWeek,
      ];
}
