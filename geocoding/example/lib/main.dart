import 'package:flutter/material.dart';

import 'package:geocoding_example/pages/geocode_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: GeocodeWidget(),
      ),
    );
  }
}
