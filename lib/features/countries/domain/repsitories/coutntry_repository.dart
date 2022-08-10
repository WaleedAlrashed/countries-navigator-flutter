import 'package:countries_navigator/core/errors/faliures.dart';
import 'package:countries_navigator/features/countries/data/models/country_model.dart';
import 'package:countries_navigator/features/countries/domain/entites/country.dart';
import 'package:dartz/dartz.dart';
import 'package:pdf/widgets.dart';

abstract class CountryRepository {
  Future<Either<Failure, List<Country>>> getCountries();

  Either<Failure, Document> generateCountryProfile(Country country);
}
