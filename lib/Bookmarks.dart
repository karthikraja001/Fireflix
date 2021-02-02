import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflix/Details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'Home.dart';

class FlixLove extends StatefulWidget {
  @override
  _FlixLoveState createState() => _FlixLoveState();
}

class _FlixLoveState extends State<FlixLove> {
  Future getData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('favourites')
        .get();
  }

  void onPopper() async {
    Navigator.pushReplacement(context,
        PageTransition(child: Home(), type: PageTransitionType.leftToRight));
  }

  _getDetails(QueryDocumentSnapshot info) {
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: Detail(info), type: PageTransitionType.rightToLeft));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
        onWillPop: () {
          onPopper();
          return Future<bool>.value(false);
        },
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                'Favourites',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              leading:
                  Icon(Icons.favorite_outline, color: Colors.pink, size: 30),
            ),
            body: Container(
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    'Your Favourites',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height - 213,
                      child: FutureBuilder(
                        future: getData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator()),
                            );
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (_, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: GestureDetector(
                                      onTap: null,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white10),
                                        child: SizedBox(
                                            child: Row(
                                          children: [
                                            SizedBox(
                                              height: 170,
                                              width: 140,
                                              child: Image.network(
                                                  snapshot.data.documents[index]
                                                      ['image'],
                                                  fit: BoxFit.cover),
                                            ),
                                            Container(
                                                width: 100,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                  child: Text(
                                                    snapshot.data
                                                            .documents[index]
                                                        ['name'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    310),
                                            IconButton(
                                                onPressed: () {
                                                  _getDetails(snapshot
                                                      .data.documents[index]);
                                                },
                                                icon: Icon(Icons.info_outline,
                                                    size: 25,
                                                    color: Colors.white))
                                          ],
                                        )),
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                      )),
                )
              ]),
            )));
  }
}
