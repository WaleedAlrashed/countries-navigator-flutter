import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplementation implements NetworkInfo {
  final InternetConnectionCheckerPlus connctionChecker;

  NetworkInfoImplementation(this.connctionChecker);

  @override
  Future<bool> get isConnected => connctionChecker.hasConnection;
}
