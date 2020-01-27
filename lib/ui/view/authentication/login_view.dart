import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterfire/core/helper/shared_manager.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((val) {
      if (SharedManager.instance.getStringValue(SharedKeys.TOKEN).isNotEmpty) {
        navigateToHome();
      }
    });
  }

  GlobalKey<ScaffoldState> scaffold = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // print(SharedManager.instance.getStringValue(SharedKeys.TOKEN));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "tag",
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
                    heroTag: "w10",
                    backgroundColor: Colors.green,
                    label: Text("Google Login"),
                    icon: Icon(Icons.outlined_flag),
                    onPressed: () async {
                      var data = await GoogleSignHelper.instance.signIn();
                      if (data != null) {
                        var userData =
                            await GoogleSignHelper.instance.firebaseSignin();
                        print(userData);
                        navigateToHome();
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

  void navigateToHome() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => FireHomeView()));
  }

  FloatingActionButton customLoginFABButton(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: "tt",
      onPressed: () async {
        var result = await service.postUser(UserRequest(
            email: username, password: password, returnSecureToken: true));

        if (result is FirebaseAuthError) {
          scaffold.currentState.showSnackBar(SnackBar(
            content: Text(result.error.message),
          ));
        } else {
          navigateToHome();
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
