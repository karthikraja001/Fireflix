import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'Home.dart';
import 'dart:convert';

class FlixSearch extends StatefulWidget {
  @override
  _FlixSearchState createState() => _FlixSearchState();
}

class _FlixSearchState extends State<FlixSearch> {
  List poster =List(10);
  List desc = List(10);
  List movie = List(10);
  bool isDone = false;
  String vidUrl = '';

  void fetchSearch() async{
    super.initState();
    var url = await http.get('https://api.themoviedb.org/3/movie/popular?api_key=f04a6a078b473a91b7fdda783e87149d&language=en-US&page=1&region=IN');
    // var yts = await http.get('https://yts.unblockit.dev/api/v2/list_movies.json?query_term=$movie');
    if(url.statusCode == 200){
      var movJson = json.decode(url.body);
      // var ytsJson = json.decode(yts.body);
      print(movJson);
      setState(() {
        for(var i =0;i<10;i++){
          desc[i] = movJson['results'][i]['overview'];
          movie[i] = movJson['results'][i]['title'];
          poster[i] = movJson['results'][i]['backdrop_path'];
        }
        print(poster);
        // try{
        //   dwnld = ytsJson['data']['movies'][0]['torrents'];
        //   dwnldLinks(dwnld);
        // }
        // catch(e){
        //   dwnld = null;
        // }
        // try{
        //   runTime = ytsJson['data']['movies'][0]['runtime'];
        // }
        // catch(e){
        //   runTime = 0;
        // }
        // try{
        //   rating = ytsJson['data']['movies'][0]['rating'];
        //   print(rating);
        // }
        // catch(e){
        //   rating = null;
        // }
        // try{
        //   mpaa = ytsJson['data']['movies'][0]['mpa_rating'];
        // }
        // catch(e){
        //   mpaa= 'None';
        // }
        // try{
        //   poster = movJson['results'];
        // }
        // catch(e){
        //   mpaa= 'None';
        // }
        // try{
        //   vidUrl = 'https://youtube.com/watch?v='+ytsJson['data']['movies'][0]['yt_trailer_code'];
        //   print(vidUrl);
        // }
        // catch(e){
        //   vidUrl= 'https://www.youtube.com/watch?v=4YKpBYo61Cs';
        // }
        isDone = true;
      });
    }
  }

  Future<List> dwnldLinks(List l) async{
    return l;
  }
  

  @override
  void initState(){
    super.initState();
    this.fetchSearch();
  }

  void onPopper() async{
    Navigator.pushReplacement(context, PageTransition(child: Home(), type: PageTransitionType.leftToRight));
  }
  @override
  Widget build(BuildContext context) {
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
          leading: Icon(Icons.search, color: Colors.white,),
          title: TextField(
            onSubmitted: null,
            decoration: InputDecoration(
              hintText: 'Search for movies,shows or genre',
              hintStyle: TextStyle(
                color: Colors.white
              ),
              suffixIcon: IconButton(
                onPressed: (){},
                icon: Icon(Icons.mic, color: Colors.grey),
              )
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:5.0),
                    child: Text('Popular Search',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  isDone==true?Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: SizedBox(
                      height: 680,
                      child: poster!=null?ListView.builder(
                        itemCount: poster.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: null,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white10
                                ),
                                child: SizedBox(
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 100,
                                        width: 170,
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w342'+poster[index],
                                          fit: BoxFit.cover
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:10.0),
                                          child: Text(
                                            movie[index],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500
                                            ),
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
                        }
                      ):
                      Center(
                        child: Text('No Downloads Available At the moment',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ):
                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()
                    ),
                  )
                ]
              ),
            ),
          ),
        )
      ),
    );
  }
}