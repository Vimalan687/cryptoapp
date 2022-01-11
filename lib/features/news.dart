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
                itemBuilder: (BuildContext context, int index,
                        int pageViewIndex) =>
                    InkWell(
                      onTap: () {
                        launch(
                          snapshot.data[index]["url"],
                        );
                      },
                      child: Card(
                        elevation: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.purple,
                                Colors.pink,
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Image.network(
                                    snapshot.data[index]['imageurl'],
                                    height: 80,
                                    fit: BoxFit.fitWidth),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 2),
                                child: RichText(
                                  maxLines: 4,
                                  overflow: TextOverflow.clip,
                                  strutStyle: StrutStyle(fontSize: 20.0),
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.white),
                                    text: snapshot.data[index]["title"],
                                  ),
                                ),
                              ),
                            ],
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
