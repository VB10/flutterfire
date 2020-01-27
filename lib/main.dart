import 'package:flutter/material.dart';
import 'package:flutterfire/ui/view/authentication/login_view.dart';
import 'package:flutterfire/ui/view/shopping_interact/shop_view.dart';
import 'package:flutterfire/ui/view/shopping_interact/shop_view_normal.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingView(),
      theme: ThemeData.light().copyWith(
          primaryIconTheme: IconThemeData(color: Colors.black, size: 20),
          backgroundColor: Color(0xFFFAF7F3)),
    );
  }
}
