// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class marketScreen extends StatefulWidget {
  const marketScreen({Key? key}) : super(key: key);

  @override
  _marketScreenState createState() => _marketScreenState();
}

class _marketScreenState extends State<marketScreen> {
  fetchAllCoins() async {
    var url = await get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=250&order=market_cap_desc&sparkline=false"));
    return json.decode(url.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchAllCoins(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          child: Image.network(
                            snapshot.data[index]["image"],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${snapshot.data[index]["name"]} (${snapshot.data[index]["symbol"].toUpperCase()})",
                            ),
                            Text(
                              "\$${snapshot.data[index]["current_price"]}",
                            ),
                          ],
                        ),
                        priceChangeEvaluator(
                          snapshot.data[index]["price_change_24h"],
                        ), // priceChangeEvaluator
                      ],
                    ),
                  )),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  priceChangeEvaluator(var d) {
    if (d == null) {
      return Container(
        child: Text("NaN"),
      );
    } else {
      if (d < 0) {
        return Container(
          child: Text(
            "${d.toStringAsFixed(2)}",
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        return Container(
          child: Text(
            "${d.toStringAsFixed(2)}",
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    }
  }
}
