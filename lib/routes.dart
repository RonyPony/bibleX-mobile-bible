
import 'package:bibleando3/screens/favorites.dart';
import 'package:bibleando3/screens/home.dart';
import 'package:bibleando3/screens/login.dart';
import 'package:bibleando3/screens/register.dart';
import 'package:bibleando3/screens/registerCompleted.dart';
import 'package:bibleando3/screens/splash.dart';
import 'package:flutter/material.dart';

final Map<String,WidgetBuilder> routes = {
SplashScreen.routeName:(context) => SplashScreen(),
LoginScreen.routeName:(context) => LoginScreen(),
RegisterScreen.routeName:(context) => RegisterScreen(),
RegisterCompletedScreen.routeName:(context) => RegisterCompletedScreen(),
HomeScreen.routeName:(context) => HomeScreen(),
FavoriteScreen.routeName:(context)=>FavoriteScreen()
};