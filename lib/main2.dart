import 'package:flutter/material.dart';
import 'package:zanimo/Screens/Home/home.dart';
import 'package:zanimo/Screens/Map/map_screen.dart';
import 'package:zanimo/Screens/Profile/profile_screen.dart';
import 'package:zanimo/constants.dart';
import 'package:zanimo/utils.dart';

class MainUserPage extends StatefulWidget {
  const MainUserPage({Key? key}) : super(key: key);

  @override
  State<MainUserPage> createState() => MainUserPageState();
}

class MainUserPageState extends State<MainUserPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    OrderTrackingPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Zanimo',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            )),
        automaticallyImplyLeading: false,
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Carte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF2B6862),
        onTap: _onItemTapped,
      ),
    );
  }
}
