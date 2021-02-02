import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FlixDownloads extends StatefulWidget {
  final String dMovie;
  final List dwnldLink;
  FlixDownloads({@required this.dMovie,@required this.dwnldLink,Key key}): super(key: key);
  @override
  _FlixDownloadsState createState() => _FlixDownloadsState();
}


class _FlixDownloadsState extends State<FlixDownloads> {

  List link = List(8);
  List dwnld = List(8);
  bool isDone = false;

  @override
  void initState(){
    super.initState();
    this.initDownloader();
    this.fetchMov();
  }

  void fetchMov() async {
    super.initState();
      setState(() {
        try {
          dwnld = widget.dwnldLink;
          dwnldLinks(dwnld);
        } catch (e) {
          dwnld = null;
        }
        isDone = true;
      });
    await FlutterDownloader.initialize(debug: true);
  }

  Future<List> dwnldLinks(List l) async {
    return l;
  }

  void initDownloader() async {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }  

  void onPopper() async {
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        onPopper();
        return Future<bool>.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Downloads',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white
            ),
          ),
          leading: IconButton(
            icon:Icon(Icons.arrow_back), 
            color: Colors.white,iconSize: 20,
            onPressed: () {
              Navigator.pop(context);
            }
          ),
        ),
        backgroundColor: Colors.black,
        body: isDone==true?
          dwnld!=null?ListView.builder(
          padding: const EdgeInsets.only(top: 250,bottom: 250),
          itemCount: dwnld.length,
          itemBuilder: (BuildContext context, int index) {
            return OutlineButton(
              onPressed: () async{
                final status = await Permission.storage.request();
                if (status.isGranted) {
                  SnackBar snackbar = SnackBar(content: Text('Download started'),);
                  Scaffold.of(context).showSnackBar(snackbar);
                  final externalDir = await getExternalStorageDirectory();
                  final id = await FlutterDownloader.enqueue(
                    url: dwnld[index]['url'],
                    savedDir: externalDir.path,
                    fileName: widget.dMovie +' - ' +dwnld[index]["type"] +'  -  ' +dwnld[index]["quality"] +' - Fireflix.torrent',
                    showNotification: true,
                    openFileFromNotification:true,
                );
              print(id);
            } else {
            print(
                'Permission Blocked');
                }
              },
              child: Center(child: Text(
                dwnld[index]["type"] +'  -  ' +dwnld[index]["quality"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                )
              ),
              borderSide: BorderSide(
                color: Colors.white,
                width: 3
              ),
            );
          }
        ):Center(
          child: Text(
            'No Downloads Available!! \nAt this Moment',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 20
            ),
            textAlign: TextAlign.center,
          )
        ):
        Center(
          child: CircularProgressIndicator()
        )
      ),
    );
  }
}