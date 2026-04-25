import 'package:bibleando3/screens/settings.dart';
import 'package:flutter/material.dart';

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
    final width = MediaQuery.of(context).size.width;
    final iconSize = width < 360 ? 24.0 : 28.0;

    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF4F46E5), Color(0xFF7C84FF)],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x334A57E9),
              offset: Offset(0, 8),
              blurRadius: 16,
            )
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          backgroundColor: Colors.transparent,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: iconSize),
              activeIcon: Icon(Icons.home_rounded, size: iconSize),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_rounded, size: iconSize),
              activeIcon: Icon(Icons.favorite_rounded, size: iconSize),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tune_rounded, size: iconSize),
              activeIcon: Icon(Icons.settings_suggest_rounded, size: iconSize),
              label: 'Ajustes',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: const Color(0xFFDCE1FF),
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
