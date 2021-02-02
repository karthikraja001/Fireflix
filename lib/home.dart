import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflix/Account.dart';
import 'package:fireflix/Auth.dart';
import 'package:fireflix/Bookmarks.dart';
import 'package:fireflix/Homepage.dart';
import 'package:fireflix/Search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Trending.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthSign authSign = AuthSign();
  int pageIndex = 0;
  PageController _pageController = PageController();
  void changePage(int pageVal) {
    setState(() {
      pageIndex = pageVal;
    });
    _pageController.jumpToPage(pageVal);
  }

  @override
  void initState() {
    super.initState();
  }

  Future getActions() async {
    final firestore = FirebaseFirestore.instance;
    Stream snapshot = firestore.collection('action').snapshots();
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        unselectedItemColor: Colors.white,
        currentIndex: pageIndex,
        selectedLabelStyle: TextStyle(color: Colors.blue),
        selectedIconTheme: IconThemeData(
          color: Colors.blue,
        ),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Favourites'),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.fire), label: 'Trending'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
        ],
        onTap: changePage,
      ),
      body: PageView(
        controller: _pageController,
        children: [FlixHome(), FlixSearch(), FlixLove(), FlixTrends(),FlixAccount()],
        onPageChanged: (value) {
          setState(() {
            pageIndex = value;
          });
        },
      ),
    );
  }
}
