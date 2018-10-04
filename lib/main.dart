import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class Coordinate {
  double latitude;
  double longitude;

  Coordinate({@required this.latitude, @required this.longitude});
}

class Place {
  int id;
  String name;
  Coordinate coordinate;

  Place({@required this.id, @required this.name, @required this.coordinate});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Place> _places = [
    Place(
      id: 1,
      name: "some place",
      coordinate: Coordinate(latitude: 52.52, longitude: 13.40),
    ),
    Place(
      id: 2,
      name: "some other place",
      coordinate: Coordinate(latitude: 51.5074, longitude: 0.1278),
    ),
    Place(
      id: 3,
      name: "some other other place",
      coordinate: Coordinate(latitude: 48.8566, longitude: 2.3522),
    )
  ];

  static const MethodChannel _channel = MethodChannel("flutter_examples/map");

  void _choosePlace(Place place) {
    _channel.invokeMethod("choosePlace", {
      "latitude": place.coordinate.latitude,
      "longitude": place.coordinate.longitude
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.pink[50],
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _places.length,
        itemBuilder: (context, i) {
          Place place = _places[i];
          return Container(
            child: InkWell(
              splashColor: Colors.pink[100],
              onTap: () => _choosePlace(place),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Center(
                  child: Text(
                    place.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Colors.pink[900],
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
