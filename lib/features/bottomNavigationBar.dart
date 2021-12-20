import 'package:flutter/material.dart';

class bottomNavigationBar extends StatelessWidget {
  const bottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BottomNavigationBar goes below here
    return BottomNavigationBar(
      backgroundColor: Colors.indigo,
      elevation: 10.0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Market',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.amber[300],
    );
  }
}
