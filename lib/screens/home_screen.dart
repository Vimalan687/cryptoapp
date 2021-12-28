import 'package:cryptoapp/features/bottomNavigationBar.dart';
import 'package:cryptoapp/features/drawer.dart';
import 'package:cryptoapp/features/trendingCoins.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR below here
      appBar: AppBar(
        centerTitle: true,
        elevation: 10.0,
        shadowColor: Colors.black,
        title: Text(widget.title),
      ),
      // DRAWER below here
      drawer: Drawer(
        child: drawer(),
      ),
      //BODY below here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            trendingCoins(),
            Text(
              'Welcome to the CryptoApp',
            ),
          ],
        ),
      ),
      // BOTTOMNAVIGATIONBAR below here
      bottomNavigationBar: bottomNavigationBar(),
    ); // This trailing comma makes auto-formatting nicer for build methods.
    // ignore: dead_code
  }
}
