import 'package:cached_network_image/cached_network_image.dart';
import 'package:countries_navigator/models/country.dart';
import 'package:countries_navigator/repositories/country_repository.dart';
import 'package:countries_navigator/services/logging_service.dart';
import 'package:countries_navigator/services/services_locator.dart';
import 'package:countries_navigator/widgets/country_list_item.dart';
import 'package:flutter/material.dart';

class CountriesListPage extends StatefulWidget {
  const CountriesListPage({Key? key}) : super(key: key);

  @override
  State<CountriesListPage> createState() => _CountriesListPageState();
}

class _CountriesListPageState extends State<CountriesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries List'),
      ),
      body: const CountriesGridViewWidget(),
    );
  }
}

class CountriesGridViewWidget extends StatefulWidget {
  const CountriesGridViewWidget({Key? key}) : super(key: key);

  @override
  State<CountriesGridViewWidget> createState() =>
      _CountriesGridViewWidgetState();
}

class _CountriesGridViewWidgetState extends State<CountriesGridViewWidget> {
  List<Country> _countries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GridView.count(
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            crossAxisCount: 4,
            cacheExtent: 100,
            children: _countries
                .map(
                  (country) => CountryListItem(
                    country: country,
                  ),
                )
                .toList(),
          );
  }

  void _fetchCountries() async {
    final log = locator<LogService>();
    final countryRepository = CountryRepository();
    var singleCountry = 'https://restcountries.com/v3.1/name/turkey';
    var region = 'https://restcountries.com/v3.1/region/europe';
    var code = 'https://restcountries.com/v3.1/alpha/syr';
    var countries = await countryRepository.getCountries();

    setState(
      () {
        _countries = countries;

        _isLoading = false;
      },
    );
  }
}
