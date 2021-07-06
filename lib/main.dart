import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
//import 'package:flutterapptestandroidestudio/modules/counter/counter.dart';
// import 'package:flutterapptestandroidestudio/bmi_calculater.dart';
import 'package:flutterapptestandroidestudio/layout/homelayout.dart';
import 'package:flutterapptestandroidestudio/shared/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
