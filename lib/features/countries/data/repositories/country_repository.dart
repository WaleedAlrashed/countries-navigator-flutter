import 'package:countries_navigator/features/countries/data/models/country_model.dart';
import 'package:countries_navigator/core/services/network_service/network_service.dart';
import 'package:countries_navigator/core/services/services_locator.dart';

class CountryRepository {
  final _networkingService = locator<NetworkService>();
  Future<List<CountryModel>> getCountries() async {
    final response = await _networkingService.get(
      '/region/europe',
    );
    if (response.statusCode == 200) {
      final jsonResponse = response.data;
      return (jsonResponse as List)
          .map((country) => CountryModel.fromJson(country))
          .toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
