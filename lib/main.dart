import 'package:flutter/material.dart';
import 'package:flutterfire/core/helper/shared_manager.dart';
import 'package:flutterfire/ui/view/authentication/login_view.dart';
import 'package:flutterfire/ui/view/home/fire_home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginView());
  }
}
