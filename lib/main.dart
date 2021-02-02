import 'package:fireflix/Auth.dart';
import 'package:fireflix/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FireSplash(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthSign authSign = AuthSign();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
            image: AssetImage('assets/images/login.jpg'),
            fit: BoxFit.cover,
          ))),
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
            Colors.transparent,
            Colors.transparent,
            Color(0xff161d27).withOpacity(0.8),
            Color(0xff161d27).withOpacity(0.9),
            Color(0xff161d27)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
          Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                "Welcome to",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40),
              ),
              SizedBox(height: 20),
              Text(
                "Fireflix",
                style: GoogleFonts.varelaRound(
                    textStyle: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 20),
              Text(
                "Download Your Favourite \nMovies from Fireflix\nFor free",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              Text(
                "Start using Fireflix by signing up in Fireflix",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              GoogleSignInButton(
                  darkMode: true,
                  onPressed: () async {
                    await authSign.googleSignIn().whenComplete(() {
                      Navigator.pushReplacement(
                          context,
                          (PageTransition(
                            child: Home(),
                            type: PageTransitionType.leftToRight,
                          )));
                    });
                  }),
              SizedBox(height: 50),
            ]),
          )
        ],
      ),
    );
  }
}
