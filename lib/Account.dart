import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflix/Auth.dart';
import 'package:fireflix/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import 'Home.dart';

class FlixAccount extends StatefulWidget {
  @override
  _FlixAccountState createState() => _FlixAccountState();
}

FirebaseFirestore firebaseFirestore;

class _FlixAccountState extends State<FlixAccount> {
  AuthSign authSign = AuthSign();
  String name = '';
  int len = 0;

  Future getData() async {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('favourites')
        .get();
    setState(() {
      len = qn.docs.length;
    });
  }

  void onPopper() async {
    Navigator.pushReplacement(context,
        PageTransition(child: Home(), type: PageTransitionType.leftToRight));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    getData();
    return WillPopScope(
      onWillPop: () {
        onPopper();
        return Future<bool>.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'My Account',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: Home(), type: PageTransitionType.leftToRight));
              }),
        ),
        body: Container(
          child: Center(
              child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Image.network(FirebaseAuth.instance.currentUser.photoURL),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                'Hello, ' + FirebaseAuth.instance.currentUser.displayName,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                'E-Mail:\t ' + FirebaseAuth.instance.currentUser.email,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                'Total Liked Movies:\t ' + len.toString(),
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: OutlineButton(
                onPressed: () {
                  showAboutDialog(
                      context: context,
                      applicationName: 'Fireflix',
                      applicationVersion: 'Version 1.0.1',
                      applicationIcon: Image.asset(
                          'assets/images/fireflix_icon.png',
                          height: 50,
                          width: 50),
                      children: [
                        Text('Developer: Karthik Raja',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Text('Created On: January 1,2021',
                            style: TextStyle(fontWeight: FontWeight.w500))
                      ]);
                },
                child: Text(
                  'About Application',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: OutlineButton(
                onPressed: () {
                  authSign.googleSignOut().whenComplete(() => {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: HomePage(),
                                type: PageTransitionType.bottomToTop))
                      });
                },
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ])),
        ),
      ),
    );
  }
}
