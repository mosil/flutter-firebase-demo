import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  static const routeName = '/input';
  final FirebaseAnalyticsObserver _observer;

  InputPage(this._observer);

  @override
  _InputPageState createState() => _InputPageState(this._observer);
}

/// 如果要追蹤流程狀態，得(with) RouteAware，
/// https://api.flutter.dev/flutter/widgets/RouteAware-class.html
class _InputPageState extends State<InputPage> with RouteAware {
  final FirebaseAnalyticsObserver _observer;
  TextEditingController _inputController;
  FocusNode _inputNode;
  int _count = 0;

  _InputPageState(this._observer);

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => _buildBody();

  @override
  void didChangeDependencies() {
    this._observer.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    this._observer.unsubscribe(this);
    this._inputController.dispose();
    super.dispose();
  }

  @override
  void didPush() {
    _sendPageAnalytics();
  }

  @override
  void didPop() {
    _sendPageAnalytics();
  }

  Widget _buildBody() {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "請輸入",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              TextField(
                focusNode: _inputNode,
                controller: _inputController,
                onSubmitted: (field) {
                  _inputNode.unfocus();
                },
                decoration: InputDecoration(
                  labelText: "輸入框",
                  hintText: "請輸入",
                ),
              ),
              RaisedButton(
                child: Text("送出事件"),
                onPressed: () {
                  _sendEventAnalytics();
                  if(_inputNode != null) {
                    _inputNode.unfocus();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sendEventAnalytics() {
    if (_inputController != null && _inputController.text.isNotEmpty) {
      _count += 1;
      _observer.analytics.logEvent(
        name: "input_event",
        parameters: <String, dynamic>{
          "input": _inputController.text,
          "count": _count,
        },
      );
      print("\n\n~~~~~");
      print("Event Log Scueess");
      print("~~~~~\n\n");
    }
  }

  _sendPageAnalytics() {
    _observer.analytics.setCurrentScreen(screenName: "${InputPage.routeName}");
  }
}
