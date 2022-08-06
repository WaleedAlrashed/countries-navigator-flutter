//import material
import 'package:cached_network_image/cached_network_image.dart';
import 'package:countries_navigator/core/widgets/full_screen_image.dart';
import 'package:countries_navigator/features/countries/domain/entites/country.dart';
import 'package:countries_navigator/features/countries/presentation/pages/country_detailS_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CountryListItem extends StatelessWidget {
  const CountryListItem({Key? key, required this.country}) : super(key: key);

  final Country country;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: GestureDetector(
            onTap: () => {
              // GoRouter.of(context).namedLocation(
              //   'preview',
              //   params: {
              //     'imageUrl': country.flags!.png.toString(),
              //     'tag': country.cca2!,
              //   },
              // )
              /**
               *   params: {
               *   'imageUrl': country.flags!.png.toString(),
               *   'tag': country.cca2!,
              *  },
               */
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FullScreenImage(
                    imageUrl: country.flags!.png.toString(),
                    tag: country.cca2!,
                  ),
                ),
              ),
            },
            child: SizedBox(
              width: 50,
              height: 50,
              child: CachedNetworkImage(
                imageUrl: country.flags!.png.toString(),
              ),
            ),
          ),
          title: Text(
            country.name?.officialNativeName.toString() ?? '',
          ),
          subtitle: Text(
            country.name?.commonNativeName.toString() ?? '',
          ),
          trailing: SizedBox(
            width: 50,
            height: 50,
            child: Text(country.cca3.toString()),
          ),
        ),
        const Divider(),
        GestureDetector(
          onTap: () {
            //navigate to country details page
            // GoRouter.of(context).namedLocation(
            //   'country_details',
            //   params: {
            //     'country': country,
            //   },
            // );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CountryDetailsPage(
                  country: country,
                ),
              ),
            );
          },
          child: ListTile(
            title: SizedBox(
              width: 100,
              height: 50,
              child: CachedNetworkImage(
                imageUrl: country.flags!.png.toString(),
              ),
            ),
            subtitle: SizedBox(
              width: 100,
              height: 50,
              child: Text(
                country.name?.officialNativeName.toString() ?? '',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
