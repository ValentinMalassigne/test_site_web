import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void startGoogleMapNavigation() async {
    String baseURL = "https://www.google.com/maps/dir/?api=1";
    String origin = "&origin=";
    String destination = "&destination=";
    String travelMode = "&travelmode=bicycling";
    String wayPointsString = "&waypoints=";

    wayPointsString += "48.947144%2C3.964808%7C";

    origin += "50.352373%2C2.854887";
    destination += "48.832315%2C1.486328";
    print(baseURL + origin + destination + travelMode + wayPointsString);
    html.window.open(
        baseURL + origin + destination + travelMode + wayPointsString,
        "_blank");
  }

  void _incrementCounter() {
    if (kIsWeb) {
      String platform = defaultTargetPlatform.name;
      switch (platform) {
        case "windows":
          print("je suis windows");
          startGoogleMapNavigation();
          break;
        case "android":
          startGoogleMapNavigation();
          break;
        case "iOS":
          print("je suis un pigeon");
          break;
        case "macOS":
          print("je suis un pigeon mac");
          break;
        default:
      }
    }

    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
