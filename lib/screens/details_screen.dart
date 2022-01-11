// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class detailsPage extends StatefulWidget {
  const detailsPage({Key? key}) : super(key: key);

  @override
  _detailsPageState createState() => _detailsPageState();
}

class _detailsPageState extends State<detailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Name'),
      ),
    );
  }
}
