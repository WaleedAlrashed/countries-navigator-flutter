import 'package:countries_navigator/core/errors/faliures.dart';
import 'package:countries_navigator/features/countries/domain/entites/country.dart';
import 'package:countries_navigator/features/countries/domain/repsitories/coutntry_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllCountriesUsecase {
  GetAllCountriesUsecase(this.repository);

  final CountryRepository repository;

  Future<Either<Failure, List<Country>>> call() async {
    return await repository.getCountries();
  }
}
