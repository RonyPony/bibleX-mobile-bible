import 'package:bibleando3/contracts/auth.contract.dart';
import 'package:bibleando3/firebase_options.dart';
import 'package:bibleando3/providers/auth.provider.dart';
import 'package:bibleando3/providers/bible.provider.dart';
import 'package:bibleando3/routes.dart';
import 'package:bibleando3/screens/splash.dart';
import 'package:bibleando3/services/auth.service.dart';
import 'package:bibleando3/services/bible.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return buildInitialInstance();
// FutureBuilder(
//       // Initialize FlutterFire
//       future: Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform,
//       ),
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return Text("Error initializing connections");
//         }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return buildInitialInstance();
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return CircularProgressIndicator();
//       },
//     );
  }

  Widget buildInitialInstance() {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BibleProvider(BibleService(),AuthService()),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(AuthService()),
        )
      ],
      child: MaterialApp(
        title: 'Bibleando',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        routes: routes,
      ),
    );
  }
}
