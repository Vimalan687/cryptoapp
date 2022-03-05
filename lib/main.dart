import 'package:cryptoapp/Authorization/auth_helper.dart';
import 'package:cryptoapp/landing_page.dart';
import 'package:cryptoapp/screens/details_screen.dart';
import 'package:cryptoapp/screens/login.dart';
import 'package:cryptoapp/screens/main_screen.dart';
import 'package:cryptoapp/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), // if user logged in or not chang the set
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            UserHelper.saveUser(snapshot.data);
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(snapshot.data!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasData && snapshot.data!.data() != null) {
                  CircularProgressIndicator();

                  final userDoc = snapshot.data;
                  final user = userDoc!.data() as Map;

                  if (user['role'] == 'user') {
                    return MyHomePage(
                      title: 'MilkyWay',
                    );
                  } else {
                    return MyHomePage(title: 'MilkyWay');
                  }
                } else {
                  return Material(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const LandingScreen(title: 'Flutter Demo Home Page'),
          );
          // return LoginPage();
          // return LandingScreen(title: 'MilkyWay');
        });
  }
}
