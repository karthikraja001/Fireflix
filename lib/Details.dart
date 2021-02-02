import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflix/Downloads.dart';
import 'package:fireflix/FlixPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:flutter_share/flutter_share.dart';
import 'home.dart';

class Detail extends StatefulWidget {
  final QueryDocumentSnapshot info;
  Detail(this.info);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  var x = 101;
  String desc = '';
  String d720 = '';
  String mpaa = '';
  int runTime = 0;
  var movieId;
  String linkImg;
  dynamic rating = 0.0;
  List link = List(8);
  List dwnld = List(8);
  bool isDone = false;
  String vidUrl = '';

  @override
  void initState() {
    super.initState();
    this.fetcMov();
  }

  void initDownloader() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(debug: true);
  }

  String isLove;
  String isSeries;

  Future<void> shareLink(dynamic link, String title) async {
    await FlutterShare.share(
        title: "Fireflix",
        text: title,
        linkUrl: link,
        chooserTitle: 'Where to Share?');
  }

  void fetcMov() async {
    super.initState();
    var movie = widget.info['name'];
    try{
      isSeries = widget.info['isSeries'];
    }
    catch(e){
      isSeries = 'no';
    }
    var url = isSeries!='yes'? await http.get(
        'https://api.themoviedb.org/3/search/movie?api_key=f04a6a078b473a91b7fdda783e87149d&language=en-US&query=$movie'):await http.get(
        'https://api.themoviedb.org/3/search/tv?api_key=f04a6a078b473a91b7fdda783e87149d&language=en-US&query=$movie&include_adult=true');
    var yts = await http.get(
        'https://yts.unblockit.dev/api/v2/list_movies.json?query_term=$movie');
    if (url.statusCode == 200) {
      var movJson = json.decode(url.body);
      var ytsJson = json.decode(yts.body);
      setState(() {
        desc = movJson['results'][0]['overview'];
        try {
          dwnld = ytsJson['data']['movies'][0]['torrents'];
          dwnldLinks(dwnld);
        } catch (e) {
          dwnld = null;
        }
        try {
          isLove = widget.info['isFavo'];
        } catch (e) {
          isLove = 'no';
        }
        try {
          isSeries = widget.info['isSeries'];
        } catch (e) {
          isSeries = 'no';
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
          runTime = ytsJson['data']['movies'][0]['runtime'];
        } catch (e) {
          runTime = 0;
        }
        try {
          rating = movJson['results'][0]['vote_average'];
        } catch (e) {
          rating = 0.0;
        }
        try {
          mpaa = ytsJson['data']['movies'][0]['mpa_rating'];
        } catch (e) {
          mpaa = 'None';
        }
        try {
          vidUrl = 'https://youtube.com/watch?v=' +
              ytsJson['data']['movies'][0]['yt_trailer_code'];
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
        body: Builder(
          builder: (context){
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
                                child: Image.network(widget.info['image'],
                                    fit: BoxFit.cover)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context).size.width - 190,
                                  child: Text(
                                    widget.info['name'],
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 25),
                                  isDone
                                      ? isLove != 'yes'
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
                                                  'image': widget.info['image'],
                                                  'name': widget.info['name'],
                                                  'isFavo': 'yes'
                                                });
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Colors.pink,
                                                size: 30,
                                              ),
                                            )
                                          : IconButton(
                                              onPressed: () async {
                                                SnackBar theSnackbar = SnackBar(content: Text('Removed from Favourites'),);
                                                Scaffold.of(context).showSnackBar(theSnackbar);
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(FirebaseAuth
                                                        .instance.currentUser.uid)
                                                    .collection('favourites')
                                                    .doc(movieId.toString())
                                                    .delete();
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.pink,
                                                size: 30,
                                              ),
                                            )
                                      : SizedBox(
                                          height: 10,
                                          width: 10,
                                          child: CircularProgressIndicator()),
                                  SizedBox(width: 25),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
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
                                      SizedBox(width: 7),
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
                                    Navigator.push(context, PageTransition(child: FlixDownloads(dMovie: widget.info['name'],dwnldLink: dwnld), type: null));
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
                                image: NetworkImage(widget.info['image']),
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
              ]
            );
          }
        ),
      ),
    );
  }
}
