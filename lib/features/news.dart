// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class newsContainer extends StatelessWidget {
  news() async {
    var url;
    url = await http.get(
        Uri.parse("https://min-api.cryptocompare.com/data/v2/news/?lang=EN"));
    return json.decode(url.body)['Data'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: news(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  pauseAutoPlayOnTouch: true,
                ),
                itemCount: snapshot.data.length,
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) =>
                        InkWell(
                          onTap: () {
                            launch(
                              snapshot.data[index]["url"],
                            );
                          },
                          child: Card(
                            elevation: 20,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 2),
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Image.network(
                                          snapshot.data[index]['imageurl'],
                                          height: 120,
                                          fit: BoxFit.fitWidth),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data[index]["title"],
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
