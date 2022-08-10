import 'dart:ui';

import 'package:countries_navigator/features/countries/presentation/bloc/countries/countries_bloc.dart';
import 'package:countries_navigator/features/countries/presentation/widgets/country_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountriesListPage extends StatelessWidget {
  const CountriesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries Navigator 🧭'),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      body: const CountriesGridViewWidget(),
    );
  }
}

class CountriesGridViewWidget extends StatelessWidget {
  const CountriesGridViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<CountriesBloc, CountriesState>(
        builder: (context, state) {
          if (state is LoadingCountriesState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedCountriesState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  addAutomaticKeepAlives: true,
                  addRepaintBoundaries: true,
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 3 : 2,
                  cacheExtent: 100,
                  children: state.countries.isEmpty
                      ? [
                          const Center(
                            child: Text('No Countries'),
                          ),
                        ]
                      : state.countries
                          .map(
                            (country) => CountryListItem(
                              country: country,
                            ),
                          )
                          .toList(),
                ),
              ),
            );
          } else if (state is ErrorCountriesState) {
            return Center(
              child: Text(state.message.toString()),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<CountriesBloc>(context).add(RefreshCountriesEvent());
  }
}
