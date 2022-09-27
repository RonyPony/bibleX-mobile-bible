import 'package:bibleando3/providers/bible.provider.dart';
import 'package:bibleando3/routes.dart';
import 'package:bibleando3/screens/splash.dart';
import 'package:bibleando3/services/bible.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BibleProvider(BibleService()),)
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
