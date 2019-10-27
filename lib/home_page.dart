import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/input_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';
  final FirebaseAnalyticsObserver _observer;

  HomePage(this._observer);

  @override
  Widget build(BuildContext context) => _buildHomeBody(context);

  Widget _buildHomeBody(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("填寫"),
                onPressed: () {
                  _sendEventAnalytics();
                  Navigator.pushNamed(context, InputPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sendEventAnalytics() {
    _observer.analytics.logEvent(name: "home_button_click");
  }
}
