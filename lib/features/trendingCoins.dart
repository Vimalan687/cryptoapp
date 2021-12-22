import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class trendingCoins extends StatefulWidget {
  const trendingCoins({Key? key}) : super(key: key);

  @override
  _trendingCoinsState createState() => _trendingCoinsState();
}

class _trendingCoinsState extends State<trendingCoins> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 200.0, autoPlay: true),
      items: [1, 2, 3, 4, 5, 6, 7].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 1.0),
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: Center(
                  child: Text(
                    'Trending $i',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ));
          },
        );
      }).toList(),
    );
  }
}
