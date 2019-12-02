import 'package:flutter/material.dart';
import 'package:flutterfire/core/model/user/user_auth_error.dart';
import 'package:flutterfire/core/model/user/user_request.dart';
import 'package:flutterfire/core/services/firebase_service.dart';
import 'package:flutterfire/ui/view/home/fire_home_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String username;
  String password;
  FirebaseService service = FirebaseService();

  GlobalKey<ScaffoldState> scaffold = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                onChanged: (val) {
                  setState(() {
                    username = val;
                  });
                },
                decoration: InputDecoration(
                    border: UnderlineInputBorder(), labelText: "Username"),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Password"),
              ),
              SizedBox(height: 10),
              FloatingActionButton.extended(
                onPressed: () async {
                  var result = await service.postUser(UserRequest(
                      email: username,
                      password: password,
                      returnSecureToken: true));

                  if (result is FirebaseAuthError) {
                    scaffold.currentState.showSnackBar(SnackBar(
                      content: Text(result.error.message),
                    ));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FireHomeView()));
                  }
                },
                label: Text("Login"),
                icon: Icon(Icons.android),
              )
            ],
          ),
        ),
      ),
    );
  }
}
