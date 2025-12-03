import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
import 'package:flutter/material.dart';
import 'package:geocoding_darwin/geocoding_darwin.dart';

/// Defines the main theme color.
final MaterialColor themeMaterialColor =
    BaseflowPluginExample.createMaterialColor(
      const Color.fromRGBO(48, 49, 60, 1),
    );

void main() {
  runApp(const GeocodeWidget());
}

/// Example [Widget] showing the use of the Geocode plugin
class GeocodeWidget extends StatefulWidget {
  /// Constructs the [GeocodeWidget] class
  const GeocodeWidget({super.key});

  /// Utility method to create a page with the Baseflow templating.
  static ExamplePage createPage() {
    return ExamplePage(Icons.location_on, (context) => const GeocodeWidget());
  }

  @override
  State<GeocodeWidget> createState() => _GeocodeWidgetState();
}

class _GeocodeWidgetState extends State<GeocodeWidget> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  String _output = '';
  Locale? _locale;
  final Geocoding _geocoding = GeocodingDarwinFactory().createGeocoding(
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
    return BaseflowPluginExample(
      pluginName: 'geocoding_darwin',
      githubURL: 'https://github.com/Baseflow/flutter-geocoding',
      pubDevURL: 'https://pub.dev/packages/geocoding',
      pages: <ExamplePage>[
        ExamplePage(Icons.location_on, (BuildContext context) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      DropdownMenu(
                        leadingIcon: Icon(Icons.language, color: Colors.white),
                        hintText: 'Locale',
                        initialSelection: Localizations.localeOf(context),
                        dropdownMenuEntries: <DropdownMenuEntry<Locale>>[
                          DropdownMenuEntry<Locale>(
                            value: Localizations.localeOf(context),
                            label: 'Default locale',
                          ),
                          DropdownMenuEntry<Locale>(
                            value: Locale('en_US'),
                            label: 'English (US)',
                          ),
                          DropdownMenuEntry<Locale>(
                            value: Locale('nl_NL'),
                            label: 'Nederlands (NL)',
                          ),
                        ],
                        onSelected: (Locale? value) =>
                            setState(() => _locale = value),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 32)),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          autocorrect: false,
                          controller: _latitudeController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: const InputDecoration(
                            hintText: 'Latitude',
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          autocorrect: false,
                          controller: _longitudeController,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: const InputDecoration(
                            hintText: 'Longitude',
                          ),
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
                        final longitude = double.parse(
                          _longitudeController.text,
                        );

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
                        _geocoding
                            .locationFromAddress(_addressController.text)
                            .then((locations) {
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
            ),
          );
        }),
      ],
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
