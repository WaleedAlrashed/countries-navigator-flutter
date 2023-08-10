import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:countries_navigator/features/countries/domain/entites/country.dart';
import 'package:countries_navigator/features/countries/presentation/bloc/countries/countries_bloc.dart';
import 'package:countries_navigator/features/countries/presentation/bloc/country_data/country_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:countries_navigator/core/services/pdf_service.dart';
import 'package:countries_navigator/core/services/services_locator.dart';

class CountryDetailsPage extends StatelessWidget {
  const CountryDetailsPage({Key? key, required this.country}) : super(key: key);

  final Country country;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // toolbarHeight: 50.0, // add this line
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       image: DecorationImage(
      //         image: CachedNetworkImageProvider(country.flags!.png.toString()),
      //         fit: BoxFit.fitWidth,
      //       ),
      //     ),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   title: Text("App Bar"),
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(country.flags!.png.toString()),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: GestureDetector(
                  onTap: () async {
                    final url =
                        'https://en.wikipedia.org/wiki/${country.name!.official!}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      Fluttertoast.showToast(
                        msg: "Could not launch $url",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                    }
                  },
                  child: AutoSizeText(country.name!.official!),
                ),
                titlePadding: const EdgeInsets.all(12.0),
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(12.0),
                    ),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        country.flags!.png.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black26,
                          Colors.black12,
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Sliver list details
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  //Country Info
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white60),
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(14.0),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0.0, 1.0),
                                color: Colors.green.withOpacity(0.1),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: const EdgeInsets.all(0.0),
                                title: AutoSizeText(
                                  "State: ${country.name!.common}",
                                  // style: AppTextStyle.title,
                                ),
                                subtitle: Text(
                                  "Capital: ${country.capital!.first}",
                                  // style: AppTextStyle.subTitles,
                                ),
                              ),
                              Text(
                                country.isIndependent
                                    ? "Independent Country"
                                    : "Not Independent Country",
                                // style: AppTextStyle.title,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  "Official Name: ${country.name!.officialNativeName}",
                                  // style: AppTextStyle.title,
                                ),
                              ),
                              Text(
                                "Region: ${country.region}",
                                // style: AppTextStyle.title,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Coat of arms:",
                                    // style: AppTextStyle.title,
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    child: CachedNetworkImage(
                                      imageUrl: country.coatOfArms!.png!,
                                      height: 80.0,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "First Day: ${country.startOfWeek}",
                                // style: AppTextStyle.title,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  "Time Zones: ${country.timezones}",
                                  // style: AppTextStyle.title,
                                ),
                              ),
                              //Icon button with pdf icon
                              IconButton(
                                icon: const Icon(Icons.picture_as_pdf_outlined),
                                onPressed: () {
                                  try {
                                    // Call the PDF service with the necessary data
                                    final pdfService = locator<PdfService>();
                                    pdfService.generateCountryProfile(country /* provide other necessary arguments here if any */);
                                  } catch (e) {
                                    // Handle exception
                                    print(e);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}