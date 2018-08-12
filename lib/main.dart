import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_music_player/bottom_controls.dart';
import 'package:flutter_music_player/songs.dart';
import 'package:flutter_music_player/theme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            color: const Color(0xFFDDDDDD),
            onPressed: () {}),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {},
              color: const Color(0xFFDDDDDD),
          )
        ],
      ),

      body: new Column(
        children: <Widget>[

          // seek bar
          new Expanded(
              child: new Center(
                child: new Container(
                  width: 125.0,
                  height: 125.0,
                  child: ClipOval(
                    clipper: new CircleClipper(),
                    child: new Image.network(
                      demoPlaylist.songs[0].albumArtUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
          ),

          // visualizer
          new Container(
            width: double.infinity,
            height: 125.0,
          ),

          // Song title, artist name, and controls
         new BottomControls()
        ],
      ),
    );
  }
}




