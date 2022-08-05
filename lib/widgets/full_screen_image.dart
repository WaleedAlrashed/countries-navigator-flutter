import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({Key? key, required this.imageUrl, required this.tag})
      : super(key: key);

  final String tag;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(tag),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(tag),
            Hero(
              tag: tag,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
