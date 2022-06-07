import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import 'package:test_site_web/map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_site_web/models/balade.dart';
import 'package:test_site_web/providers/balades_provider.dart';
import 'package:test_site_web/services/firestore_api.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final FirestoreApi _firestoreApi = FirestoreApi();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BaladeProvider(allBalade: []),
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: FutureBuilder<List<Balade>>(
                future: _firestoreApi.getBalade(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError == false) {
                      // update the provider with call back because of being inside a future builder
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Provider.of<BaladeProvider>(context, listen: false)
                            .updateBalades(snapshot.data!);
                      });

                      return MyHomePage();
                    } else {
                      return Scaffold(
                        body: Center(child: Text(snapshot.error.toString())),
                      );
                    }
                  }
                  // loading
                  else {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                }),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BaladeProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String platfrom = '';
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
      platfrom = defaultTargetPlatform.name;
      switch (platfrom) {
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

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(provider.allBalade.first.name)),
      body: Center(
        child: GoogleMapWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
