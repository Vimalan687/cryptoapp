
import 'dart:convert';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

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
              scrollDirection: Axis.vertical,
              height: 120,
              autoPlay: true,
              pauseAutoPlayOnTouch: true,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
                Stack(
              children: [
                Container(
                  color: Colors.purple[700],
                  width: MediaQuery.of(context).size.width,
                ),
                ClipRRect(
                  // Clip it cleanly.
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.blueGrey, width: 1),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.0, vertical: 5.0),
                      alignment: Alignment.center,
                      child: trendingCoinViewer(snapshot, index),
                    ),
                  ),
                ),
              ],
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

trendingCoinViewer(AsyncSnapshot snapshot, int index) {
  return InkWell(
    onTap: () {
      // Goes to Details Page
    },
    child: Container(
      child: ListTile(
        leading: Image.network(
          snapshot.data[index]["item"]["large"],
        ),
        title: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.grey,
          child: Text(
            '${snapshot.data[index]["item"]["name"]} (${snapshot.data[index]["item"]["symbol"]})',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        subtitle: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.yellow,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Rank: ${snapshot.data[index]["item"]["market_cap_rank"]}',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Price in BTC: ${snapshot.data[index]["item"]["price_btc"]}',
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
