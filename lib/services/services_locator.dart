import 'package:countries_navigator/services/logging_service.dart';
import 'package:countries_navigator/services/network_service/network_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future setupServicesLocator() async {
  locator.registerLazySingleton(() => NetworkService());
  locator.registerLazySingleton(() => LogService());
}
