// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class favouritesScreen extends StatefulWidget {
  const favouritesScreen({Key? key}) : super(key: key);

  @override
  _favouritesScreenState createState() => _favouritesScreenState();
}

class _favouritesScreenState extends State<favouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("This is the Favourites page"),
    );
  }
}
