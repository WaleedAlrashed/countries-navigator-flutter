import 'package:countries_navigator/core/services/services_locator.dart';
import 'package:countries_navigator/core/router/routes.dart';
import 'package:flutter/material.dart';

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
