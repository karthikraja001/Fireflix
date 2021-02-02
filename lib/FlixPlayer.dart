import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'home.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class FlixPlayer extends StatefulWidget {
  final String vidUrl;
  FlixPlayer({this.vidUrl});
  @override
  _FlixPlayerState createState() => _FlixPlayerState();
}

class _FlixPlayerState extends State<FlixPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'FlixPlayer',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: Home(), type: PageTransitionType.leftToRight));
            },
          ),
        ),
        backgroundColor: Colors.black,
        body: FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: "AIzaSyDTWiI8H7P2cz9xvvV8nxLDURp5z7L0wj0",
          videoUrl: widget.vidUrl,
        ));
  }
}
