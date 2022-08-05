//import material
import 'package:cached_network_image/cached_network_image.dart';
import 'package:countries_navigator/models/country.dart';
import 'package:countries_navigator/router/route_definition.dart';
import 'package:countries_navigator/widgets/full_screen_image.dart';
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
        ListTile(
          title: SizedBox(
            width: 200,
            height: 50,
            child: CachedNetworkImage(
              imageUrl: country.flags!.png.toString(),
            ),
          ),
          subtitle: SizedBox(
            width: 200,
            height: 50,
            child: Text(
              country.name?.officialNativeName.toString() ?? '',
            ),
          ),
        ),
      ],
    );
  }
}
