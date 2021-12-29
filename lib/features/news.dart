import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  news() async {
    var url;
    url = await http.get(
        Uri.parse("https://min-api.cryptocompare.com/data/v2/news/?lang=EN"));
    print(url.body);
    return json.decode(url.body)['Data'];
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      backgroundColor: Color(0xff191826),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'NEWS',
          style: TextStyle(fontSize: 25.0, color: Color(0xfff43370)),
        ),
        backgroundColor: Color(0xff191826),
      ),

      body: FutureBuilder(
        
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
                              snapshot.data[index]["url"],);
                        },
                  child: Card(
            
                                  child: Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 1, 15, 0),

                   
                    child: Center(
                      child: Column(

                        
                        
                          children: [
                            Image.network(snapshot.data[index]['imageurl'],  
                                           height: 120,
                                          fit: BoxFit.fitWidth ),
                          SizedBox(height: 10,),
                          Text(
                          snapshot.data[index]["title"],
                                                    textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.black,fontSize: 16,),
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
          }),
    );
  }
}
