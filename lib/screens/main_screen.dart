import 'package:cryptoapp/features/drawer.dart';
import 'package:cryptoapp/screens/favourites_screen.dart';
import 'package:cryptoapp/screens/home_screen.dart';
import 'package:cryptoapp/screens/market_screen.dart';
import 'package:cryptoapp/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;
  static List<Widget> _pageScreens = <Widget>[
    homeScreen(),
    marketScreen(),
    favouritesScreen(),
    profileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // APPBAR below here
      appBar: AppBar(
        centerTitle: true,
        elevation: 10.0,
        shadowColor: Colors.black,
        title: Shimmer.fromColors(
            baseColor: Colors.amber,
            highlightColor: Colors.yellowAccent,
            child: Text(widget.title)),
      ),
      // DRAWER below here
      drawer: Drawer(
        child: drawer(),
      ),
      //BODY below here
      body: Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                'https://www.icegif.com/wp-content/uploads/2021/10/icegif-1641.gif',
                fit: BoxFit.fill,
              ),
            ),
            _pageScreens.elementAt(_selectedIndex)
          ],
        ),
      ),
      // BOTTOMNAVIGATIONBAR below here
      bottomNavigationBar: BottomNavigationBar(
        onTap: changePage,
        iconSize: 20,
        currentIndex: _selectedIndex,
        // elevation: 10.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            tooltip: "Welcome to homescreen ",
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        showUnselectedLabels: false,
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
    // ignore: dead_code
  }

  void changePage(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
