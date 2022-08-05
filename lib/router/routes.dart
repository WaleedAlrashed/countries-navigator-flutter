import 'package:countries_navigator/pages/countries_list_page.dart';
import 'package:countries_navigator/pages/error_page.dart';
import 'package:countries_navigator/router/route_definition.dart';
import 'package:countries_navigator/widgets/full_screen_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: RoutesDefnitions.home,
  routes: <GoRoute>[
    GoRoute(
      name: 'countries_list_page',
      path: RoutesDefnitions.home,
      builder: (BuildContext context, GoRouterState state) =>
          const CountriesListPage(),
    ),
    GoRoute(
      name: 'preview',
      path: RoutesDefnitions.preview,
      builder: (BuildContext context, GoRouterState state) => FullScreenImage(
        imageUrl: state.params['imageUrl'] as String,
        tag: state.params['tag'] as String,
      ),
    ),
  ],
  errorBuilder: (context, state) => ErrorPage(error: state.error!),
);
