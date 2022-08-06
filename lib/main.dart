import 'package:countries_navigator/core/services/services_locator.dart' as di;
import 'package:countries_navigator/core/router/routes.dart';
import 'package:countries_navigator/features/countries/presentation/bloc/countries/countries_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootStrapApplication();
  runApp(const MainAppClass());
}

class MainAppClass extends StatelessWidget {
  const MainAppClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<CountriesBloc>()
            ..add(
              GetAllCountriesEvent(),
            ),
        ),
      ],
      child: MaterialApp.router(
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        title: 'Countries Navigator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const CountriesListPage(),
      ),
    );
  }
}

bootStrapApplication() async {
  await di.setupServicesLocator();
}
