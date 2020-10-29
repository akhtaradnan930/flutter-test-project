import 'package:flutter/material.dart';
import 'package:flutter_test_project/providers/auth_provider.dart';
import 'package:flutter_test_project/screens/login_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).getUser();

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value.isLoggedIn) {
            return loggedInContainer(context, value);
          }
          return logoutContainer(context);
        },
      ),
    );
  }

  Widget logoutContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Spacer(),
          Text(
            "You are not logged in",
            style: TextStyle(fontSize: 30),
          ),
          Spacer(),
          Container(
            alignment: Alignment.bottomRight,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                "Log In",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget loggedInContainer(BuildContext context, AuthProvider value) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('assets/images/user.jpeg', width: 60),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Adnan Akhtar"),
                  SizedBox(height: 4),
                  Text(
                    "Uploaded Feb 19, 2020",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 15),
          Text("Email"),
          SizedBox(height: 5),
          TextFormField(
            initialValue: value.user.email,
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
          ),
          SizedBox(height: 10),
          Text("Password"),
          SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            initialValue: "**************",
            decoration: InputDecoration(
              focusColor: Colors.black,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(),
              hintText: "e.g. johndeo@mail.com",
            ),
          ),
          Spacer(),
          Container(
            alignment: Alignment.bottomRight,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                "Log Out",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                value.logout();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
