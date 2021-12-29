// ignore_for_file: camel_case_types

import 'package:cryptoapp/features/trendingCoins.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.amber.withOpacity(0.5)
                // image: DecorationImage(
                //     image: NetworkImage(
                //       "https://previews.123rf.com/images/lishchyshyn/lishchyshyn1904/lishchyshyn190400512/121588471-struktur-der-netzwerkverbindung-abstrakter-technologiehintergrund-futuristischer-hintergrund-digital.jpg?fj=1",
                //     ),
                //     fit: BoxFit.fitWidth),
                ),
            child: Center(
              child: Text(
                "Trending Coins",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          trendingCoins(),
        ],
      ),
    );
  }
}
