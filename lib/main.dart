import 'package:flutter/material.dart';
import 'package:flutterfire/ui/view/authentication/login_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginView());
  }
}
