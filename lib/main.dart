import 'package:flutter/material.dart';
import 'package:flutterfire/ui/view/fire_home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: FireHomeView());
  }
}
