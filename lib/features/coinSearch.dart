// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:cryptoapp/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:searchfield/searchfield.dart';

class searchCoins extends StatefulWidget {
  const searchCoins({Key? key}) : super(key: key);

  @override
  _searchCoinsState createState() => _searchCoinsState();
}

class _searchCoinsState extends State<searchCoins> {
  List coinsTemp = [], matches = [];
  List<String> coins = [];

  @override
  void initState() {
    super.initState();
    fetchAllCoinsName();
  }

  fetchAllCoinsName() async {
    var url;
    var index = 0;
    url = await get(
      Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=1000&page=1&sparkline=false"),
    );
    try {
      while (json.decode(url.body)[index]['item'].toString().isNotEmpty) {
        coins.add(json.decode(url.body)[index]['name']);
        index = index + 1;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController selectedCoin = new TextEditingController();

    return SearchField(
      marginColor: Colors.purple,
      controller: selectedCoin,
      suggestions: coins,
      maxSuggestionsInViewPort: 5,
      onTap: (selectedCoin) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const detailsPage(),
        ),
      ),
    );
  }
}
