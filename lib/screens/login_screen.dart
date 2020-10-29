import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/user.dart';
import 'package:flutter_test_project/screens/home_screen.dart';
import 'package:flutter_test_project/services/auth_service.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isLoading = false;
  AuthService authService = AuthService();

  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _isLoading = true;
      });
      authService
          .login('eve.holt@reqres.in', 'password')
          .then((UserModel user) {
        if (user == null) {
          setState(() {
            _isLoading = false;
          });
          // some problem
        } else {
          prefs.setString('token', user.token);
          prefs.setString('email', _email);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
          // logging;
          //Navigate to home screen
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Center(
                        child: Text(
                          "Welcome",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .apply(color: Colors.black),
                        ),
                      ),
                    ),
                    Text("Email"),
                    SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(),
                        hintText: "e.g. johndeo@mail.com",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                      onSaved: (newValue) => _email = newValue,
                    ),
                    SizedBox(height: 10),
                    Text("Password"),
                    SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(),
                        hintText: "enter password",
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      onSaved: (newValue) => _password = newValue,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          login();
                        },
                      ),
                    ),
                    Center(
                      child: MaterialButton(
                        onPressed: () {},
                        child: Text(
                          "Forget Password",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    Center(
                      child: Text("Or"),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      child: OutlineButton(
                        child: Text("Explore The App"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
