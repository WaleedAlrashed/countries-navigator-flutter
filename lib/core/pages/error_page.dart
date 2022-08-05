//error page

import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, required this.error}) : super(key: key);

  final Exception error;
  @override
  Widget build(BuildContext context) {
    //scaffold with error message
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Text(error.toString()),
      ),
    );
  }
}
