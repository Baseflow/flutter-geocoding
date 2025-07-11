import 'package:flutter/material.dart';
import 'package:geocoding_darwin/geocoding_darwin.dart';

import '../template/globals.dart';

/// Example [Widget] showing the use of the Geocode plugin
class GeocodeWidget extends StatefulWidget {
  /// Constructs the [GeocodeWidget] class
  const GeocodeWidget({super.key});

  @override
  State<GeocodeWidget> createState() => _GeocodeWidgetState();
}

class _GeocodeWidgetState extends State<GeocodeWidget> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  String _output = '';
  Locale? _locale;
  final GeocodingDarwin _geocoding = GeocodingDarwin(
    GeocodingDarwinCreationParams(),
  );

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
          const Padding(padding: EdgeInsets.only(top: 32)),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  autocorrect: false,
                  controller: _latitudeController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(hintText: 'Latitude'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  autocorrect: false,
                  controller: _longitudeController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(hintText: 'Longitude'),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Center(
            child: ElevatedButton(
              child: const Text('Look up address'),
              onPressed: () {
                final latitude = double.parse(_latitudeController.text);
                final longitude = double.parse(_longitudeController.text);

                _geocoding
                    .placemarkFromCoordinates(
                      latitude,
                      longitude,
                      locale: _locale,
                    )
                    .then((placemarks) {
                      var output = 'No results found.';
                      if (placemarks.isNotEmpty) {
                        output = placemarks[0].toDisplayString();
                      }

                      setState(() {
                        _output = output;
                      });
                    });
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 32)),
          TextField(
            autocorrect: false,
            controller: _addressController,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(hintText: 'Address'),
            keyboardType: TextInputType.text,
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Center(
            child: ElevatedButton(
              child: const Text('Look up location'),
              onPressed: () {
                _geocoding.locationFromAddress(_addressController.text).then((
                  locations,
                ) {
                  var output = 'No results found.';
                  if (locations.isNotEmpty) {
                    output = locations[0].toDisplayString();
                  }

                  setState(() {
                    _output = output;
                  });
                });
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Center(
            child: ElevatedButton(
              child: const Text('Is present'),
              onPressed: () {
                _geocoding.isPresent().then((isPresent) {
                  var output = isPresent
                      ? "Geocoder is present"
                      : "Geocoder is not present";
                  setState(() {
                    _output = output;
                  });
                });
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Center(
            child: ElevatedButton(
              child: const Text('Set locale en_US'),
              onPressed: () {
                setState(() => _locale = Locale('en_US'));
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Center(
            child: ElevatedButton(
              child: const Text('Set locale nl_NL'),
              onPressed: () {
                setState(() => _locale = Locale('nl_NL'));
              },
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(_output),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension _PlacemarkExtensions on Placemark {
  String toDisplayString() {
    return '''
      Name: $name, 
      Street: $street, 
      ISO Country Code: $isoCountryCode, 
      Country: $country, 
      Postal code: $postalCode, 
      Administrative area: $administrativeArea, 
      Subadministrative area: $subAdministrativeArea,
      Locality: $locality,
      Sublocality: $subLocality,
      Thoroughfare: $thoroughfare,
      Subthoroughfare: $subThoroughfare''';
  }
}

extension _LocationExtensions on Location {
  String toDisplayString() {
    return '''
      Latitude: $latitude,
      Longitude: $longitude,
      Timestamp: $timestamp''';
  }
}
