// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class trendingCoins extends StatefulWidget {
  const trendingCoins({Key? key}) : super(key: key);

  @override
  _trendingCoinsState createState() => _trendingCoinsState();
}

class _trendingCoinsState extends State<trendingCoins> {
  fetchTrendingCoins() async {
    var url;
    url = await get(
        Uri.parse("https://api.coingecko.com/api/v3/search/trending"));
    return json.decode(url.body)['coins'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchTrendingCoins(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CarouselSlider.builder(
            options: CarouselOptions(
              height: 125,
              autoPlay: true,
              pauseAutoPlayOnTouch: true,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
                Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                  // style: BorderStyle.
                ),
              ),
              child: Center(
                child: ListTile(
                  leading: Image.network(
                    snapshot.data[index]["item"]["large"],
                  ),
                  title: Text(
                    '${snapshot.data[index]["item"]["name"]} (${snapshot.data[index]["item"]["symbol"]})',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rank: ${snapshot.data[index]["item"]["market_cap_rank"]}',
                      ),
                      Text(
                        'Price in BTC: ${snapshot.data[index]["item"]["price_btc"]}',
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
