import 'package:countries_navigator/core/errors/exceptions.dart';
import 'package:countries_navigator/core/services/services_locator.dart';
import 'package:countries_navigator/features/countries/data/models/country_model.dart';
import 'package:countries_navigator/core/services/services.dart';

abstract class CountryRemoteDataSource {
  Future<List<CountryModel>> getCountries();
}

class CountryRemoteDataSourceImplementation implements CountryRemoteDataSource {
  final networkService = locator<NetworkService>();
  CountryRemoteDataSourceImplementation();
  @override
  Future<List<CountryModel>> getCountries() async {
    final response = await networkService.get(
      '/region/europe',
    );
    if (response.statusCode == 200) {
      final jsonResponse = response.data;
      return (jsonResponse as List)
          .map<CountryModel>((country) => CountryModel.fromJson(country))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
