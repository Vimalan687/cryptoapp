// ignore_for_file: camel_case_types

import 'package:cryptoapp/features/coinSearch.dart';
import 'package:cryptoapp/features/news.dart';
import 'package:cryptoapp/features/trendingCoins.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

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
          sectionTitle("Trending Coins"),
          trendingCoins(),
          sectionTitle("News"),
          newsContainer(),
        ],
      ),
    );
  }

  sectionTitle(String title) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
