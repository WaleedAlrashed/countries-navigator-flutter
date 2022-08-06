import 'package:countries_navigator/core/errors/exceptions.dart';
import 'package:countries_navigator/core/services/services.dart';
import 'package:countries_navigator/core/services/services_locator.dart';
import 'package:countries_navigator/features/countries/data/models/country_model.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';

abstract class CountryLocalDataSource {
  Future<List<CountryModel>> getCachedCountries();
  Future<Unit> cacheCountries(List<CountryModel> countryModels);
}

const cashedPosts = "CACHED_POSTS";

class CountryLocalDatSourceImplementation implements CountryLocalDataSource {
  //TOOD insject shared preferences via services locator
  final localStorage = locator<LocalStorageService>();

  CountryLocalDatSourceImplementation();

  @override
  Future<Unit> cacheCountries(List<CountryModel> countryModels) {
    List countryModelsToJson = countryModels
        .map<Map<String, dynamic>>((countryModel) => countryModel.toJson())
        .toList();

    localStorage.saveToDisk<String>(
        cashedPosts, json.encode(countryModelsToJson));

    return Future.value(unit);
  }

  @override
  Future<List<CountryModel>> getCachedCountries() {
    final jsonString = localStorage.getFromDisk(cashedPosts);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<CountryModel> jsonToCountryModel = decodeJsonData
          .map<CountryModel>(
              (jsonPostModel) => CountryModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToCountryModel);
    } else {
      throw EmptyCacheException();
    }
  }
}
