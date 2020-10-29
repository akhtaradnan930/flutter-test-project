import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test_project/providers/auth_provider.dart';
import 'package:flutter_test_project/screens/home_screen.dart';
import 'package:flutter_test_project/screens/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initialiseApp() async {
    var userProvider = Provider.of<AuthProvider>(context, listen: false);
    userProvider.getUser();
    var duration = Duration(seconds: 2);

    return Timer(duration, () async {
      if (userProvider.isLoggedIn) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      }
    });
  }

  @override
  void initState() {
    initialiseApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "LOGO",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Loading, Please wait"),
            SizedBox(height: 10),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
