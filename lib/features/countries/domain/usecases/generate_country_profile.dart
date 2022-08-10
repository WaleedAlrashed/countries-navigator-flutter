import 'package:countries_navigator/core/errors/faliures.dart';
import 'package:countries_navigator/features/countries/data/models/country_model.dart';
import 'package:countries_navigator/features/countries/domain/entites/country.dart';
import 'package:countries_navigator/features/countries/domain/repsitories/coutntry_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:pdf/widgets.dart';

class GenerateCountryProfileUsecase {
  GenerateCountryProfileUsecase(this.repository);

  final CountryRepository repository;

  Either<Failure, Document> call(Country country) {
    return repository.generateCountryProfile(country);
  }
}
