import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflix/FlixPlayer.dart';
import 'package:fireflix/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'Downloads.dart';

class FlixSeriesDetails extends StatefulWidget {
  final String movie;
  final String poster;
  FlixSeriesDetails({@required this.movie, @required this.poster, Key key})
      : super(key: key);
  @override
  FlixSeriesDetailsState createState() => FlixSeriesDetailsState();
}

class FlixSeriesDetailsState extends State<FlixSeriesDetails> {
  var x = 101;
  String desc = '';
  var movieId;
  String d720 = '';
  String mpaa = '';
  int runTime = 0;
  String linkImg;
  dynamic rating = 0.0;
  List link = List(8);
  List dwnld = List(8);
  bool isDone = false;
  String vidUrl = '';

  Future<void> shareLink(dynamic link, String title) async {
    await FlutterShare.share(
        title: "Fireflix",
        text: title,
        linkUrl: link,
        chooserTitle: 'Where to Share?');
  }

  @override
  void initState() {
    super.initState();
    this.fetcMov();
    initDownloader();
  }

  void initDownloader() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(debug: true);
  }

  void fetcMov() async {
    super.initState();
    var movie = widget.movie;
    var url = await http.get(
        'https://api.themoviedb.org/3/search/tv?api_key=f04a6a078b473a91b7fdda783e87149d&language=en-US&page=1&query=$movie&include_adult=true');
    if (url.statusCode == 200) {
      var movJson = json.decode(url.body);
      setState(() {
        try {
          desc = movJson['results'][0]['overview'];
        } catch (e) {
          dwnld = null;
        }
        try {
          linkImg = movJson['results'][0]['poster_path'];
        } catch (e) {
          linkImg =
              'https://drive.google.com/file/d/1BaWyXffBq6Yb-XOyzeDfkqvG7nFzIlkT/view?usp=sharing';
        }
        try {
          movieId = movJson['results'][0]['id'];
        } catch (e) {
          movieId = null;
        }
        try {
          rating = movJson['results'][0]['vote_average'];
        } catch (e) {
          rating = 0.0;
        }
        try {
          mpaa = 'None';
        } catch (e) {
          mpaa = 'None';
        }
        try {
          vidUrl = 'https://www.youtube.com/watch?v=4YKpBYo61Cs';
        } catch (e) {
          vidUrl = 'https://www.youtube.com/watch?v=4YKpBYo61Cs';
        }
        isDone = true;
      });
    }
  }

  Future<List> dwnldLinks(List l) async {
    return l;
  }

  void onPopper() async {
    Navigator.pushReplacement(context,
        PageTransition(child: Home(), type: PageTransitionType.leftToRight));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        onPopper();
        return Future<bool>.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Builder(
          builder: (context) {
          return CustomScrollView(slivers: <Widget>[
            SliverAppBar(
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: SizedBox(
                                height: 250,
                                width: 150,
                                child: Image.network(widget.poster,
                                    fit: BoxFit.cover)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context).size.width - 30,
                                  child: Text(
                                    widget.movie,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 25),
                              isDone
                                  ? IconButton(
                                      onPressed: () async {
                                        SnackBar snackbar = SnackBar(content: Text('Added to Favourites'),);
                                        Scaffold.of(context).showSnackBar(snackbar);
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth
                                                .instance.currentUser.uid)
                                            .collection('favourites')
                                            .doc(movieId.toString())
                                            .set({
                                          'image': widget.poster,
                                          'name': widget.movie,
                                          'isSeries': 'yes',
                                          'isFavo':'yes'
                                        });
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.pink,
                                        size: 30,
                                      ),
                                    )
                                  : SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: CircularProgressIndicator()),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        runTime.toString() + '  Mins',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                              Container(
                                  height: 40,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Image.network(
                                          'https://img.icons8.com/color/96/000000/imdb.png',
                                          scale: 2,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(width: 7),
                                      Text(
                                        rating.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )),
                              Container(
                                  height: 40,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          mpaa,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                          isDone==true?Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width - 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: OutlineButton.icon(
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FlixPlayer(
                                                  vidUrl: vidUrl,
                                                )));
                                  },
                                  icon: Icon(
                                    Icons.play_arrow,
                                    color: Colors.black,
                                  ),
                                  label: Text(
                                    'Play Trailer',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ),
                          ):Center(
                            
                          ),
                          isDone==true?Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width - 30,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(5)),
                              child: FlatButton.icon(
                                  onPressed: () {
                                    Navigator.push(context, PageTransition(child: FlixDownloads(dMovie: widget.movie,dwnldLink: dwnld,), type: PageTransitionType.leftToRight));
                                  },
                                  icon: Icon(
                                    Icons.download_outlined,
                                    color: Colors.black,
                                  ),
                                  label: Text(
                                    'Download',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ):Center(
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 20),
                            child: SizedBox(
                              height: 200,
                              width: MediaQuery.of(context).size.width - 30,
                              child: Text(
                                desc,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ]),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.poster),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black87, BlendMode.darken)))),
                  ),
                ),
                expandedHeight: 900,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, size: 30, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => Home()));
                  },
                )),
          ]);
          },
        ),
      ),
    );
  }
}
