import 'package:flutter/material.dart';
import 'package:geocoding_android/geocoding_android.dart';

import '../template/globals.dart';

/// Example [Widget] showing the use of the Geocode plugin
class GeocodeWidget extends StatefulWidget {
  @override
  _GeocodeWidgetState createState() => _GeocodeWidgetState();
}

class _GeocodeWidgetState extends State<GeocodeWidget> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  String _output = '';

  @override
  void initState() {
    _addressController.text = 'Gronausestraat 710, Enschede';
    _latitudeController.text = '52.2165157';
    _longitudeController.text = '6.9437819';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: defaultHorizontalPadding + defaultVerticalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 32),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  autocorrect: false,
                  controller: _latitudeController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Latitude',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  autocorrect: false,
                  controller: _longitudeController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Longitude',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          Center(
            child: ElevatedButton(
                child: Text('Look up address'),
                onPressed: () {
                  final latitude = double.parse(_latitudeController.text);
                  final longitude = double.parse(_longitudeController.text);

                  GeocodingAndroid()
                      .placemarkFromCoordinates(latitude, longitude)
                      .then((placemarks) {
                    var output = 'No results found.';
                    if (placemarks.isNotEmpty) {
                      output = placemarks[0].toString();
                    }

                    setState(() {
                      _output = output;
                    });
                  });
                }),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 32),
          ),
          TextField(
            autocorrect: false,
            controller: _addressController,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: 'Address',
            ),
            keyboardType: TextInputType.text,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          Center(
            child: ElevatedButton(
                child: Text('Look up location'),
                onPressed: () {
                  GeocodingAndroid()
                      .locationFromAddress(_addressController.text)
                      .then((locations) {
                    var output = 'No results found.';
                    if (locations.isNotEmpty) {
                      output = locations[0].toString();
                    }

                    setState(() {
                      _output = output;
                    });
                  });
                }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(_output),
              ),
            ),
          )
        ],
      ),
    );
  }
}
