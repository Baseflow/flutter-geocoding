import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class GeocodeWidget extends StatefulWidget {
  @override
  _GeocodeWidgetState createState() => _GeocodeWidgetState();
}

class _GeocodeWidgetState extends State<GeocodeWidget> {
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  @override
  void initState() {
    _latitudeController.text = '52.2165157';
    _longitudeController.text = '6.9437819';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: TextField(
                  autocorrect: false,
                  controller: _latitudeController,
                  decoration: InputDecoration(
                    hintText: 'Latitude',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Flexible(
                child: TextField(
                  autocorrect: false,
                  controller: _longitudeController,
                  decoration: InputDecoration(
                    hintText: 'Longitude',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ),
        Center(
          child: RaisedButton(
              child: Text('Look up'),
              onPressed: () {
                final latitude = double.parse(_latitudeController.text);
                final longitude = double.parse(_longitudeController.text);

                placemarkFromCoordinates(latitude, longitude)
                    .then((placemarks) {
                  print(placemarks[0].toString());
                });
              }),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
