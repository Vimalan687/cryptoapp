import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// ignore: camel_case_types for this file
class TrendingCoin {
  final int rank;
  final int id;
  final String name;
  final String symbol;
  final String imageUrl;
  final double price;

  TrendingCoin({
    required this.rank,
    required this.id,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
  });
}

// ignore: camel_case_types
class trendingCoins extends StatefulWidget {
  const trendingCoins({Key? key}) : super(key: key);

  @override
  _trendingCoinsState createState() => _trendingCoinsState();
}

// ignore: camel_case_types
class _trendingCoinsState extends State<trendingCoins> {
  getTrendingData() async {
    var url = Uri.parse('https://api.coingecko.com/api/v3/search/trending');
    var response = await get(url);
    var jsonData = jsonDecode(response.body);
    print(jsonData["coins"][0]);

    // List<TrendingCoin> coins = [];

    // for (var i in jsonData["coins"]) {
    //   TrendingCoin coinData = TrendingCoin(
    //       id: jsonData["id"],
    //       imageUrl: jsonData["coins"]["thumb"],
    //       name: jsonData["coins"][i]["name"],
    //       price: jsonData["coins"][i]["price_btc"],
    //       rank: jsonData["coins"][i]["market_cap_rank"],
    //       symbol: jsonData["coins"][i]["symbol"]);
    //   coins.add(coinData);
    // }
    // print(coins.length);
  }

  // API to use : https://api.coingecko.com/api/v3/search/trending
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(autoPlay: true),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.cyan[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: ElevatedButton(
                      child: Text('click me'),
                      onPressed: () {
                        getTrendingData();
                      }),
                ));
          },
        );
      }).toList(),
    );
  }
}
