import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/home_page.dart';
import 'package:flutter_firebase_demo/input_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase Demo",
      theme: ThemeData(primaryColor: Colors.blue),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(observer),
        InputPage.routeName: (context) => InputPage(observer),
      },
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}
