import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding_darwin/clgeocoder.dart' as cl;

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
  final cl.CLGeocoder _geocoder = cl.CLGeocoder();

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
                      onPressed: _reverseGeocode,
                      child: const Text('Look up address'),
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
                      onPressed: _forwardGeocode,
                      child: const Text('Look up location'),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => _output = 'Geocoder is present');
                      },
                      child: const Text('Is present'),
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

  cl.Locale? _nativeLocale() {
    return _locale != null ? cl.Locale(identifier: _locale!.toString()) : null;
  }

  Future<void> _reverseGeocode() async {
    setState(() => _output = 'Loading...');

    try {
      final latitude = double.parse(_latitudeController.text);
      final longitude = double.parse(_longitudeController.text);

      final placemarks = await _geocoder.reverseGeocodeLocation(
        cl.CLLocation(latitude: latitude, longitude: longitude),
        _nativeLocale(),
      );

      var output = 'No results found.';
      if (placemarks != null && placemarks.isNotEmpty) {
        output = placemarks[0].toDisplayString();
      }

      setState(() => _output = output);
    } on PlatformException catch (e) {
      setState(() => _output = 'Error: ${e.message ?? e.code}');
    } on FormatException catch (e) {
      setState(() => _output = 'Error: ${e.message}');
    }
  }

  Future<void> _forwardGeocode() async {
    setState(() => _output = 'Loading...');

    try {
      final placemarks = await _geocoder.geocodeAddressString(
        _addressController.text,
        _nativeLocale(),
      );

      var output = 'No results found.';
      if (placemarks != null && placemarks.isNotEmpty) {
        final cl.CLLocation? location = placemarks[0].location;
        output = location != null
            ? await location.toDisplayString()
            : 'No location found.';
      }

      setState(() => _output = output);
    } on PlatformException catch (e) {
      setState(() => _output = 'Error: ${e.message ?? e.code}');
    }
  }
}

extension _CLPlacemarkExtensions on cl.CLPlacemark {
  String toDisplayString() {
    return '''
      Name: $name, 
      Street: ${postalAddress?.street ?? thoroughfare}, 
      ISO Country Code: $isoCountryCode, 
      Country: $country, 
      Postal code: ${postalAddress?.postalCode ?? postalCode}, 
      Administrative area: $administrativeArea, 
      Subadministrative area: $subAdministrativeArea,
      Locality: $locality,
      Sublocality: $subLocality,
      Thoroughfare: $thoroughfare,
      Subthoroughfare: $subThoroughfare''';
  }
}

extension _CLLocationExtensions on cl.CLLocation {
  Future<String> toDisplayString() async {
    final cl.CLLocationCoordinate2D coordinate = await getCoordinate();
    final int timestamp = await getTimestamp();

    return '''
      Latitude: ${coordinate.latitude},
      Longitude: ${coordinate.longitude},
      Timestamp: ${DateTime.fromMillisecondsSinceEpoch(timestamp)}''';
  }
}
