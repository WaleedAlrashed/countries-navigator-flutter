import 'package:countries_navigator/models/country.dart';
import 'package:countries_navigator/services/network_service/network_service.dart';
import 'package:countries_navigator/services/services_locator.dart';

class CountryRepository {
  final _networkingService = locator<NetworkService>();
  Future<List<Country>> getCountries() async {
    final response = await _networkingService.get(
      '/region/europe',
    );
    if (response.statusCode == 200) {
      final jsonResponse = response.data;
      return (jsonResponse as List)
          .map((country) => Country.fromJson(country))
          .toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
