import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:fireflix/home.dart';
import 'package:fireflix/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireSplash extends StatefulWidget {
  @override
  _FireSplashState createState() => _FireSplashState();
}

class _FireSplashState extends State<FireSplash> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    loadPage();
  }

  Future<void> loadPage() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('uid');
    uid == null
        ? Timer(
            Duration(seconds: 2),
            () => {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: HomePage(),
                          type: PageTransitionType.rightToLeft))
                })
        : Timer(
            Duration(seconds: 2),
            () => {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: Home(), type: PageTransitionType.fade))
                });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Image(
                  image: AssetImage('assets/images/fireflix_icon.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text('Fireflix',
                style: GoogleFonts.varelaRound(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold))),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(backgroundColor: Colors.black),
            )
          ],
        )),
      ),
    );
  }
}
