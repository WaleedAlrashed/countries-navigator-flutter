import 'package:countries_navigator/core/helpers/network_info.dart';
import 'package:countries_navigator/features/countries/data/datasources/country_local_data_source.dart';
import 'package:countries_navigator/features/countries/data/datasources/country_remote_data_source.dart';
import 'package:countries_navigator/features/countries/data/repositories/country_repository_implementation.dart';
import 'package:countries_navigator/features/countries/domain/repsitories/coutntry_repository.dart';
import 'package:countries_navigator/features/countries/domain/usecases/get_all_countries.dart';
import 'package:countries_navigator/features/countries/presentation/bloc/countries/countries_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:countries_navigator/core/services/services.dart';

GetIt locator = GetIt.instance;

Future<void> setupServicesLocator() async {
  locator.registerLazySingleton(() => NetworkService());
  locator.registerLazySingleton(() => LogService());

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<LocalStorageService>(
    LocalStorageService(preferences: sharedPreferences),
  );

  //Bloc
  locator.registerFactory(
    () => CountriesBloc(
      getAllCountries: locator(),
    ),
  );
  //use cases
  locator.registerLazySingleton<GetAllCountriesUsecase>(
    () => GetAllCountriesUsecase(
      locator(),
    ),
  );

  //repositories

  locator.registerLazySingleton<CountryRepository>(
    () => CountryRepositoryImplementation(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  //DataSources

  locator.registerLazySingleton<CountryRemoteDataSource>(
    () => CountryRemoteDataSourceImplementation(),
  );

  locator.registerLazySingleton<CountryLocalDataSource>(
    () => CountryLocalDatSourceImplementation(),
  );

  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImplementation(
      locator(),
    ),
  );

// External Services
  // final sharedPreferences = await SharedPreferences.getInstance();
  // locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  locator.registerLazySingleton(() => InternetConnectionCheckerPlus());
}
