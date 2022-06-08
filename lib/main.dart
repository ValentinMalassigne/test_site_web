import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import 'package:test_site_web/map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_site_web/models/balade.dart';
import 'package:test_site_web/providers/balades_provider.dart';
import 'firebase_options.dart';
import 'services/firebase_api.dart';
import 'widgets/box_section.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final FirebaseApi _firebaseApi = FirebaseApi();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
=======
    return ChangeNotifierProvider(
        create: (context) => BaladeProvider(allBalade: [Balade()]),
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: FutureBuilder<List<Balade>>(
                future: _firebaseApi.getBalade(),
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
>>>>>>> master
  }
}

class MyHomePage extends StatefulWidget {
<<<<<<< HEAD
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
=======
  MyHomePage({Key? key}) : super(key: key);
>>>>>>> master

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

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<BaladeProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(text: "Balade Patrimoine"),
              Tab(text: "Balade Nature"),
              Tab(text: "Carte")
            ]),
            title: Text(provider.allBalade.first.name)),
        body: const TabBarView(
          children: [
            //boxList(0),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_car),
            Center(
              child: GoogleMapWidget(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: startGoogleMapNavigation,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget boxList(int baladeIndex) {
    List<Balade> baladeList = Provider.of<BaladeProvider>(context).allBalade;
    print(baladeList[0].description);
    return ListView.builder(
      itemCount: baladeList[baladeIndex].wayPointsLst?.length,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        int cpt =
            0; // on fait appel à un compteur car l'index 0 l'image est vide ça va faire de la merde avec les marges
        // on vérifie qu'il y a bien une image à afficher
        if (baladeList[baladeIndex].wayPointsLst?[index].firebaseFile != null) {
          double rightMargin = 0;
          double leftMargin = 0;
          cpt != 0 ? rightMargin = 15 : rightMargin = 45;
          cpt != 0 ? leftMargin = 15 : leftMargin = 45;
          cpt++;
          return boxListSection(
            index,
            rightMargin,
            leftMargin,
            baladeList[baladeIndex].wayPointsLst![index],
            baladeList[baladeIndex],
            //() => _goToPreview(baladeIndex0),
          );
        }
        return Container();
      },
    );
  }

  void startGoogleMapNavigation() async {
    String baseURL = "https://www.google.com/maps/dir/?api=1";
    String origin = "&origin=";
    String destination = "&destination=";
    String travelMode = "&travelmode=bicycling";
    String wayPointsString = "&waypoints=";

    wayPointsString += "48.947144%2C3.964808%7C";
<<<<<<< HEAD

=======
>>>>>>> master
    origin += "50.352373%2C2.854887";
    destination += "48.832315%2C1.486328";
    print(baseURL + origin + destination + travelMode + wayPointsString);
    html.window.open(
        baseURL + origin + destination + travelMode + wayPointsString,
        "_blank");
  }
<<<<<<< HEAD

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
=======
>>>>>>> master
}
