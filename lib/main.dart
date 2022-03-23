import 'package:flutter/material.dart';
import 'dart:developer';

void main() {
  runApp(
    const Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: HomePage(),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  AppLifecycleState _lastLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    log("Current state: initState");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    log("Current state: dispose");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    setState(() {
      _lastLifecycleState = state;
      log("Current state: $state");
    });
  }

  @override
  Widget build(BuildContext context) {
    log("Current state: build");
    if (_lastLifecycleState == null) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text("Lifecycle")),
          body: Center(
            child: Text('This widget has not observed any lifecycle changes.'),
          ),
        ),
      );
    } else {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text("Lifecycle")),
          body: Center(
            child: Text('The most recent lifecycle state this widget observed was: $_lastLifecycleState.'),
          ),
        ),
      );
    }
  }
}
