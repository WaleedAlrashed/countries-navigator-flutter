import 'package:countries_navigator/router/routes.dart';
import 'package:flutter/material.dart';
import 'services/services_locator.dart';

void main() async {
  bootStrapApplication();
  runApp(const MainAppClass());
}

class MainAppClass extends StatelessWidget {
  const MainAppClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      title: 'Countries Navigator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const CountriesListPage(),
    );
  }
}

bootStrapApplication() async {
  await setupServicesLocator();
}
