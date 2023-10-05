import 'package:flutter/material.dart';
import 'package:movie_app/utils/font.dart';
import 'package:movie_app/widgets/torated.dart';
import 'package:movie_app/widgets/trending.dart';
import 'package:movie_app/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';
void main()=> runApp(new Myapp());
class Myapp extends StatelessWidget  {

//  String? myNullableString ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:  Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark,
      ),

 // home: Scaffold(
 //
 //   appBar: AppBar(title: Text('Null Handling Example')),
 //   body: Center(
 //     // Handling the nullable string using a conditional check
 //
 //     child: Text(myNullableString != null ? myNullableString : print("null")),
 //   ),
 // ),
    );
  }

}
class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();


  }
  class _HomeState extends State<Home>{


  final String apikey = 'ddf4f328e2eadf1c5e918ae37247d69b';
  String token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZGY0ZjMyOGUyZWFkZjFjNWU5MThhZTM3MjQ3ZDY5YiIsInN1YiI6IjY0ZTI1ZmMzZTE5ZGU5MDEwMGU5NzVhMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.h-oC7OySPJp9MYzm6_R8wfQ54x4S2PKAZezqJBjCyrU';

  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];

  @override
  void initState() {
    loadmovies();
    super.initState();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, token),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult =await tmdbWithCustomLogs.v3.tv.getPopular();
    print((trendingresult));
    setState(() {
      trendingmovies= trendingresult['results'];
      topratedmovies= topratedresult['results'];
      tv = tvresult['results'];
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: modified_text(text: ('MOVIES' ), color: Colors.blueAccent,size: 30 ,),),
      body: ListView(
        children: [
          TopRatedMovies(toprated: topratedmovies),
          TrendingMovies(trending: trendingmovies),

          TV(tv: tv),
        ],
      ),
    );
  }

}



