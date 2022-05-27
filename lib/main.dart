import 'package:countries_navigator/pages/countries_list_page.dart';
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
    return MaterialApp(
      title: 'Countries Navigator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CountriesListPage(),
    );
  }
}

bootStrapApplication() async {
  await setupServicesLocator();
}
