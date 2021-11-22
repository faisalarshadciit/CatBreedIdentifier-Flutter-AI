import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'home_page.dart';

class MySplashScreen extends StatefulWidget {

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: HomePage(),
      title: Text(
        "Cat Breed Identifier",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
          color: Colors.pink,
          fontFamily: "Signatra"
        ),
        textAlign: TextAlign.center,
      ),
      image: Image.asset('assets/images/icon.jpg'),
      backgroundColor: Colors.white,
      photoSize: 180,
      loaderColor: Colors.red,
      loadingText: Text(
        "From Coding Cafe",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.pinkAccent,
            fontFamily: "Brand Bold"
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
