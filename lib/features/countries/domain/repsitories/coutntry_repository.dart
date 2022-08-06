import 'package:countries_navigator/core/errors/faliures.dart';
import 'package:countries_navigator/features/countries/domain/entites/country.dart';
import 'package:dartz/dartz.dart';

abstract class CountryRepository {
  Future<Either<Failure, List<Country>>> getCountries();
}
