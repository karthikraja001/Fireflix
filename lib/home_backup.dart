import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireflix/Auth.dart';
import 'package:fireflix/main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'Details.dart';


class FlixHome extends StatefulWidget {
  @override
  _FlixHomeState createState() => _FlixHomeState();
}


class _FlixHomeState extends State<FlixHome> {
  AuthSign authSign = AuthSign();
  
  int pageIndex = 0;
  PageController _pageController = PageController();
  void changePage(int pageVal){
    setState(() {
      pageIndex = pageVal;
    });
    _pageController.jumpToPage(pageVal);
  } 


  Future getActions() async{    
    final firestore = FirebaseFirestore.instance;
    Stream snapshot = firestore.collection('action').snapshots();
    return snapshot;
  }

  _getDetails(QueryDocumentSnapshot info){
    Navigator.pushReplacement(context, PageTransition(child: Detail(info), type: PageTransitionType.rightToLeft));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search,color: Colors.white,),label:  'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle,color: Colors.white,),label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark,color: Colors.white,),label: 'Bookmarks'),
        ],
        onTap: changePage,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.black87,
            leading: Image.asset('assets/images/temp_logo.png',scale: 13.0,),
            actions: <Widget>[
              MaterialButton(
                onPressed: (){},
                child: Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Text(
                    'Movies',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: (){},
                child: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Text(
                    'Bookmarks',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: (){
                  authSign.googleSignOut().whenComplete(() => {
                    Navigator.pushReplacement(context, PageTransition(child: HomePage(), type: PageTransitionType.rightToLeft))
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 250,
              child: Image.network('https://lightbox-prod.imgix.net/images/uploads/1595549712454-john-wick-chapter-3-parabellum-2019-cc1.jpg',fit: BoxFit.fill,)
            )
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: (){},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add,size: 30,color: Colors.white,),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Add To List',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white
                          ),
                        )
                      )
                    ]
                  )
                ),
                MaterialButton(
                  onPressed: (){},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: (){}, 
                        child: Icon(Icons.play_arrow,color: Colors.white,size: 30,)
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Play Trailer',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white
                          ),
                        ),
                      )
                    ],
                  )
                ),
                MaterialButton(
                  onPressed: (){},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: (){}, 
                        child: Icon(Icons.info,color: Colors.white,size: 30,)
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Info',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white
                          ),
                        ),
                      )
                    ],
                  )
                )
              ]
            )
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 290,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0,right: 250),
                    child: Text('Your WishList',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0,left: 15),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 170,
                                width: 170,
                                child: Image.network('https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTDuzrnxIkh11AqI-6PrU9Qrycml22OhFHM9UwGmlkxCsPctLTr',fit:BoxFit.fill),
                              ),
                              LinearProgressIndicator(value: 50),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.minimize_outlined,color: Colors.white,size: 30,),
                                  ),
                                  IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.info,color: Colors.white,size: 25,),
                                  )
                                ],
                              )
                            ]
                          ),
                        ),
                      ],
                    ),
                  )
                ]
              ),  
            )
          ),

          //Action Page
          SliverToBoxAdapter(
            child: SizedBox(
              height:310,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right:260.0),
                    child: Text('Action Movies',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 230,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('action').snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        else{
                          print(snapshot.data);
                          return Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (_,index){
                              DocumentSnapshot actionData = snapshot.data.documents[index];
                              return GestureDetector(
                                  onTap: (){ _getDetails(snapshot.data.documents[index]);},
                                  child: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: SizedBox(
                                    height: 150,
                                    width: 100,
                                    child: Column(
                                      children: [
                                        Image.network(actionData['image'],fit: BoxFit.fill),
                                        Text(actionData['name'],
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                            );
                        }
                      }
                    ),
                  )
                ],
              )
            )
          ),

          //Comedy
          SliverToBoxAdapter(
            child: SizedBox(
              height:270,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right:320.0),
                    child: Text('Comedy',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 200,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Comedy').snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        else{
                          print(snapshot.data);
                          return Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (_,index){
                                DocumentSnapshot comedyData = snapshot.data.documents[index];
                                print(comedyData['name']);
                                return GestureDetector(
                                    onTap: (){ _getDetails(snapshot.data.documents[index]);},
                                    child: Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: SizedBox(
                                      height: 150,
                                      width: 100,
                                      child: Column(
                                        children: [
                                          Image.network(comedyData['image'],fit: BoxFit.fill),
                                          Text(comedyData['name'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            ),
                          );
                        }
                      }
                    ),
                  )
                ],
              )
            )
          ),

          //Documentary
          SliverToBoxAdapter(
            child: SizedBox(
              height:260,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right:265.0),
                    child: Text('Documentary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 210,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Documentary').snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        else{
                          print(snapshot.data);
                          return Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (_,index){
                              DocumentSnapshot comedyData = snapshot.data.documents[index];
                              print(comedyData['name']);
                              return GestureDetector(
                                  onTap: (){ _getDetails(snapshot.data.documents[index]);},
                                  child: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: SizedBox(
                                    height: 170,
                                    width: 100,
                                    child: Column(
                                      children: [
                                        Image.network(comedyData['image'],fit: BoxFit.fill),
                                        Text(comedyData['name'],
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                            );
                        }
                      }
                    ),
                  )
                ],
              )
            )
          ),


          //Drama
          SliverToBoxAdapter(
            child: SizedBox(
              height:240,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right:330.0),
                    child: Text('Drama',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 190,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Drama').snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        else{
                          print(snapshot.data);
                          return Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (_,index){
                              DocumentSnapshot comedyData = snapshot.data.documents[index];
                              print(comedyData['name']);
                              return GestureDetector(
                              onTap: (){ _getDetails(snapshot.data.documents[index]);},
                              child: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: SizedBox(
                                    height: 160,
                                    width: 100,
                                    child: Column(
                                      children: [
                                        Image.network(comedyData['image'],fit: BoxFit.fill),
                                        Text(comedyData['name'],
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                            );
                        }
                      }
                    ),
                  )
                ],
              )
            )
          ),


          //Kids
          SliverToBoxAdapter(
            child: SizedBox(
              height:300,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right:330.0),
                    child: Text('Kids',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 250,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Kids').snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        else{
                          print(snapshot.data);
                          return Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (_,index){
                              DocumentSnapshot comedyData = snapshot.data.documents[index];
                              print(comedyData['name']);
                              return GestureDetector(
                              onTap: (){ _getDetails(snapshot.data.documents[index]);},
                              child: Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: SizedBox(
                                    height: 150,
                                    width: 100,
                                    child: Column(
                                      children: [
                                        Image.network(comedyData['image'],fit: BoxFit.fill),
                                        Text(comedyData['name'],
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                            );
                        }
                      }
                    ),
                  )
                ],
              )
            )
          ),

        ] 
      ),
    );
  }
}