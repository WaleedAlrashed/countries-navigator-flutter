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
      '/region/america',
    );
    if (response.statusCode == 200) {
      final jsonResponse = response.data;
      var countriesList = (jsonResponse as List)
          .map<CountryModel>((country) => CountryModel.fromJson(country))
          .toList();
      //filter countries list
      countriesList.removeWhere((country) => country.cca2 == 'IL');
      return countriesList;
    } else {
      throw ServerException();
    }
  }
}
