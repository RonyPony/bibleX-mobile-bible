import 'dart:io';

import 'package:bibleando3/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/favorites.dart';
import '../screens/home.dart';

class BottomMenu extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  BottomMenu({Key? key, required this.currentIndex}) : super(key: key);
  final int currentIndex;
  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      if (_selectedIndex != index) {
        if (index == 0) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        }
        if (index == 1) {
          Navigator.pushNamedAndRemoveUntil(
              context, FavoriteScreen.routeName, (route) => false);
        }
        if (index == 2) {
          Navigator.pushNamedAndRemoveUntil(
              context, SettingScreen.routeName, (route) => false);
        }
        _selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
      return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0, top: 0, left: 0, right: 0),
          child: Container(
            padding: EdgeInsets.only(bottom: 0),
            decoration: BoxDecoration(
                color: Colors.blue,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color.fromRGBO(0, 0, 255, 100),
                    const Color.fromRGBO(5, 0, 255, 10)
                  ],
                ),
                borderRadius: BorderRadius.circular(40)),
            child: BottomNavigationBar(
              elevation: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: Colors.transparent,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 35,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    size: 35,
                  ),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 35,
                  ),
                  label: 'Settings',
                ),
              ],
              currentIndex: _selectedIndex,
              unselectedItemColor: Color(0xffcccccc),
              selectedItemColor: Colors.white,
              onTap: _onItemTapped,
            ),
          ),
        ),
      );
  }
}
