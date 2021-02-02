import 'package:fireflix/SeriesDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'Home.dart';
import 'SearchDetails.dart';
import 'dart:convert';

class FlixSearch extends StatefulWidget {
  @override
  _FlixSearchState createState() => _FlixSearchState();
}

class _FlixSearchState extends State<FlixSearch> {
  List poster = List(10);
  List desc = List(10);
  List movie = List(10);
  List searchposter = List(10);
  List searchdesc = List(10);
  List searchmovie = List(10);
  List seriesposter = List(10);
  List seriesdesc = List(10);
  List seriesmovie = List(10);  
  bool isDone = false;
  String vidUrl = '';

  Future<void> fetchSearch() async {
    super.initState();
    var url = await http.get('https://api.themoviedb.org/3/movie/popular?api_key=f04a6a078b473a91b7fdda783e87149d&language=en-US&page=1&region=IN');
    if (url.statusCode == 200) {
      var movJson = json.decode(url.body);
      setState(() {
        for (var i = 0; i < 10; i++) {
          desc[i] = movJson['results'][i]['overview'];
          movie[i] = movJson['results'][i]['title'];
          poster[i] = movJson['results'][i]['backdrop_path'];
        }
        isDone = true;
      });
    }
  }

  Future<List> dwnldLinks(List l) async {
    return l;
  }

  Future<void> searchBarChange(var mov) async {
    var query = mov;
    var searchQuery = await http.get('https://api.themoviedb.org/3/search/movie?api_key=f04a6a078b473a91b7fdda783e87149d&language=en-US&query=$query');
    var seriesQuery = await http.get('https://api.themoviedb.org/3/search/tv?api_key=f04a6a078b473a91b7fdda783e87149d&language=en-US&page=1&query=$query&include_adult=true');
    if (searchQuery.statusCode == 200 && seriesQuery.statusCode == 200) {
      var sqJson = json.decode(searchQuery.body);
      var serJson = json.decode(seriesQuery.body);
      var len = sqJson['results'].length > 10 ? 10 : sqJson['results'].length;
      var serLen = serJson['results'].length > 10? 10: serJson['results'].length; 
      for (var i = 0; i < 10; i++) {
        desc[i] = null;
        movie[i] = '';
        poster[i] = null;
      }
      for(var j=0;j<10;j++){
        seriesmovie[j] = null;
        seriesdesc[j] = '';
        seriesposter[j] = null;
      }
      setState(() {
        for (var i = 0; i < len; i++) {
          desc[i] = sqJson['results'][i]['overview'];
          movie[i] = sqJson['results'][i]['title'];
          poster[i] = sqJson['results'][i]['backdrop_path'];
        }
        for(var j=0;j<serLen;j++){
          seriesposter[j] = serJson['results'][j]['backdrop_path'];
          seriesmovie[j] = serJson['results'][j]['original_name'];
          seriesdesc[j] = serJson['results'][j]['overview'];
        }
        isDone = true;
      });
    }
  }

  var _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
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
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Icon(
              Icons.search,
              color: Colors.white,
            ),
            title: TextField(
              onSubmitted: (value) {
                searchBarChange(value);
                _controller.clear();
              },
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  hintText: 'Search for movies,shows or genre',
                  hintStyle: TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.mic, color: Colors.grey),
                  )),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: 910,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'Movie Search',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      isDone == true
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SizedBox(
                                height: 230,
                                child: poster != null
                                    ? ListView.builder(
                                        itemCount: poster.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    PageTransition(
                                                        child: FlixSearchDetails(
                                                            movie:
                                                                movie[index] !=
                                                                        null
                                                                    ? movie[
                                                                        index]
                                                                    : '-',
                                                            poster: poster[
                                                                        index] !=
                                                                    null
                                                                ? 'https://image.tmdb.org/t/p/w342' +
                                                                    poster[
                                                                        index]
                                                                : 'https://www.ledr.com/colours/grey.jpg'),
                                                        type: PageTransitionType
                                                            .leftToRight));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white10),
                                                child: SizedBox(
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 100,
                                                        width: 170,
                                                        child: Image.network(
                                                            poster[index] !=
                                                                    null
                                                                ? 'https://image.tmdb.org/t/p/w342' +
                                                                    poster[
                                                                        index]
                                                                : 'https://www.ledr.com/colours/grey.jpg',
                                                            fit: BoxFit.cover),
                                                      ),
                                                      Container(
                                                        width: 200,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: Text(
                                                            movie[index] != null
                                                                ? movie[index]
                                                                : '-',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.play_arrow,
                                                        color: Colors.grey,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                    : Center(
                                        child: Text(
                                          'No Downloads Available At the moment',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                              ),
                            )
                          : Center(
                              child: SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: Center(
                                    child: Text(
                                      'Search Results Appear here',
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'TV Series',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      isDone == true
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SizedBox(
                                height: 600,
                                child: poster != null
                                    ? ListView.builder(
                                        itemCount: poster.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    PageTransition(
                                                        child: FlixSeriesDetails(
                                                            movie:
                                                                seriesmovie[index] !=
                                                                        null
                                                                    ? seriesmovie[
                                                                        index]
                                                                    : '-',
                                                            poster: seriesposter[
                                                                        index] !=
                                                                    null
                                                                ? 'https://image.tmdb.org/t/p/w342' +
                                                                    seriesposter[
                                                                        index]
                                                                : 'https://www.ledr.com/colours/grey.jpg'),
                                                        type: PageTransitionType
                                                            .leftToRight));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white10),
                                                child: SizedBox(
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 100,
                                                        width: 170,
                                                        child: Image.network(
                                                            seriesposter[index] !=
                                                                    null
                                                                ? 'https://image.tmdb.org/t/p/w342' +
                                                                    seriesposter[
                                                                        index]
                                                                : 'https://www.ledr.com/colours/grey.jpg',
                                                            fit: BoxFit.cover),
                                                      ),
                                                      Container(
                                                        width: 200,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: Text(
                                                            seriesmovie[index] != null
                                                                ? seriesmovie[index]
                                                                : '-',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.play_arrow,
                                                        color: Colors.grey,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                    : Center(
                                        child: Text(
                                          'No Downloads Available At the moment',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                              ),
                            )
                          : Center(
                              child: SizedBox(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: Center(
                                    child: Text(
                                      'Search Results Appear here',
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            )

                    ]),
              ),
            ),
          )),
    );
  }
}
