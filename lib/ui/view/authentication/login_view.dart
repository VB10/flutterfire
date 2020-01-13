import 'package:flutter/material.dart';
import 'package:flutterfire/core/model/user/user_auth_error.dart';
import 'package:flutterfire/core/model/user/user_request.dart';
import 'package:flutterfire/core/services/firebase_service.dart';
import 'package:flutterfire/core/services/google_signin.dart';
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () async {
          await GoogleSignHelper.instance.signOut();
        },
      ),
      key: scaffold,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              usernameTextField(),
              emptySizedBox(),
              passwordTextField(),
              emptySizedBox(),
              Wrap(
                spacing: 10,
                children: <Widget>[
                  FloatingActionButton.extended(
                    backgroundColor: Colors.green,
                    label: Text("Google Login"),
                    icon: Icon(Icons.outlined_flag),
                    onPressed: () async {
                      var data = await GoogleSignHelper.instance.signIn();
                      if (data != null) {
                        var userData =
                            await GoogleSignHelper.instance.googleAuthtencite();
                        print(userData.accessToken);
                        // print(userData.idToken);
                      }
                    },
                  ),
                  customLoginFABButton(context)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton customLoginFABButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        var result = await service.postUser(UserRequest(
            email: username, password: password, returnSecureToken: true));

        if (result is FirebaseAuthError) {
          scaffold.currentState.showSnackBar(SnackBar(
            content: Text(result.error.message),
          ));
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FireHomeView()));
        }
      },
      label: Text("Login"),
      icon: Icon(Icons.android),
    );
  }

  TextField passwordTextField() {
    return TextField(
      onChanged: (val) {
        setState(() {
          password = val;
        });
      },
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
    );
  }

  SizedBox emptySizedBox() => SizedBox(height: 10);

  TextField usernameTextField() {
    return TextField(
      onChanged: (val) {
        setState(() {
          username = val;
        });
      },
      decoration: InputDecoration(
          border: UnderlineInputBorder(), labelText: "Username"),
    );
  }
}
