import 'dart:async';
import 'dart:ui' as ui;

import 'package:baseflow_plugin_template/baseflow_plugin_template.dart';
import 'package:flutter/material.dart';
import 'package:geocoding_android/geocoder.dart';

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
  final TextEditingController _lowerLeftLatitudeBoundController =
      TextEditingController();
  final TextEditingController _lowerLeftLongitudeBoundController =
      TextEditingController();
  final TextEditingController _upperRightLatitudeBoundController =
      TextEditingController();
  final TextEditingController _upperRightLongitudeBoundController =
      TextEditingController();
  String _output = '';
  String? _locale;

  (Geocoder, GeocodeListener) _createGeocoderWithListener() {
    final geocoderInstance = Geocoder(
      locale: Locale(
        identifier:
            _locale ?? ui.PlatformDispatcher.instance.locale.languageCode,
      ),
    );

    final listener = GeocodeListener(
      onGeocode: (GeocodeListener listener, List<Address?> addresses) {
        _buildOutputFromAddresses(addresses);
      },
      onError: (GeocodeListener instance, String? errorMessage) {
        setState(() {
          _output = 'Error: ${errorMessage ?? "Unknown error"}';
        });
      },
    );

    return (geocoderInstance, listener);
  }

  @override
  void initState() {
    super.initState();

    _addressController.text = 'Gronausestraat';
    _latitudeController.text = '52.2165157';
    _longitudeController.text = '6.9437819';
    _lowerLeftLatitudeBoundController.text = '52.207778';
    _lowerLeftLongitudeBoundController.text = '6.925356';
    _upperRightLatitudeBoundController.text = '52.224816';
    _upperRightLongitudeBoundController.text = '6.979773';
  }

  Future<void> _buildOutputFromAddresses(List<Address?> addresses) async {
    final buffer = StringBuffer();

    for (int i = 0; i < addresses.length; i++) {
      final address = addresses[i];
      if (address == null) continue;

      final addressLine = await address.getAddressLine(0);
      final locality = await address.getLocality();
      final adminArea = await address.getAdminArea();
      final countryName = await address.getCountryName();
      final postalCode = await address.getPostalCode();
      final lat = await address.getLatitude();
      final lng = await address.getLongitude();

      buffer.writeln('--- Address ${i + 1} ---');
      buffer.writeln('Address line: $addressLine');
      buffer.writeln('Locality: $locality');
      buffer.writeln('Admin area: $adminArea');
      buffer.writeln('Country: $countryName');
      buffer.writeln('Postal code: $postalCode');
      buffer.writeln('Lat/Lng: $lat, $lng');
    }

    if (buffer.isEmpty) {
      buffer.write('No results found.');
    }

    setState(() {
      _output = buffer.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseflowPluginExample(
      pluginName: 'geocoding_android',
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
                  _languageSelector(context),
                  const Padding(padding: EdgeInsets.only(top: 32)),
                  _isPresent(),
                  const Padding(padding: EdgeInsets.only(top: 32)),
                  _getFromLocation(context),
                  const Padding(padding: EdgeInsets.only(top: 32)),
                  _getFromLocationName(context),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  // -- Output display --
                  Expanded(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          _output,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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

  Widget _languageSelector(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        DropdownMenu(
          leadingIcon: Icon(Icons.language, color: Colors.white),
          hintText: 'Locale',
          initialSelection: Localizations.localeOf(context).toString(),
          dropdownMenuEntries: <DropdownMenuEntry<String>>[
            DropdownMenuEntry<String>(
              value: Localizations.localeOf(context).toString(),
              label: 'Default locale',
            ),
            DropdownMenuEntry<String>(value: 'en', label: 'English (US)'),
            DropdownMenuEntry<String>(value: 'nl', label: 'Nederlands (NL)'),
          ],
          onSelected: (String? value) => setState(() => _locale = value),
        ),
      ],
    );
  }

  Widget _isPresent() {
    final isPresent = Geocoder.isPresent();

    return FutureBuilder<Widget>(
      future: isPresent.then(
        (present) => Text(
          'Is geocoder present on this device? ${present ? "Yes" : "No"}',
        ),
      ),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return snapshot.data!;
        }
      },
    );
  }

  Widget _getFromLocation(BuildContext context) {
    return Column(
      children: [
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

              setState(() => _output = 'Loading...');

              final (geocoderInstance, listener) =
                  _createGeocoderWithListener();

              /// If you're on Pre Android API 33, you need to use getFromLocationPreAndroidApi33.
              geocoderInstance.getFromLocation(
                latitude,
                longitude,
                5,
                listener,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _getFromLocationName(BuildContext context) {
    return Column(
      children: [
        TextField(
          autocorrect: false,
          controller: _addressController,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: const InputDecoration(hintText: 'Address'),
          keyboardType: TextInputType.text,
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                autocorrect: false,
                controller: _lowerLeftLatitudeBoundController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: 'Lower left latitude bound',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                autocorrect: false,
                controller: _lowerLeftLongitudeBoundController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: 'Lower left longitude bound',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                autocorrect: false,
                controller: _upperRightLatitudeBoundController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: 'Upper right latitude bound',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                autocorrect: false,
                controller: _upperRightLongitudeBoundController,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: const InputDecoration(
                  hintText: 'Upper right longitude bound',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 8)),
        Center(
          child: ElevatedButton(
            child: const Text('Look up location'),
            onPressed: () {
              setState(() => _output = 'Loading...');

              final lowerLeftLatitude = double.parse(
                _lowerLeftLatitudeBoundController.text,
              );
              final lowerLeftLongitude = double.parse(
                _lowerLeftLongitudeBoundController.text,
              );
              final upperRightLatitude = double.parse(
                _upperRightLatitudeBoundController.text,
              );
              final upperRightLongitude = double.parse(
                _upperRightLongitudeBoundController.text,
              );

              final (geocoderInstance, listener) =
                  _createGeocoderWithListener();

              /// If you're on Pre Android API 33, you need to use getFromLocationNamePreAndroidApi33.
              geocoderInstance.getFromLocationName(
                _addressController.text,
                5,
                listener,
                GeographicBounds(
                  lowerLeftLatitude: lowerLeftLatitude,
                  lowerLeftLongitude: lowerLeftLongitude,
                  upperRightLatitude: upperRightLatitude,
                  upperRightLongitude: upperRightLongitude,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
