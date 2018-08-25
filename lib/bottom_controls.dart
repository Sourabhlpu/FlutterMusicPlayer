import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_music_player/theme.dart';


//this widget is creating the bottom part of the screen where we have the controls and the song name and the artist name.
class BottomControls extends StatelessWidget {
  const BottomControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,

      // when we try to give splash and highlight color to the next and previous button it looks for immediate material widget
      // TODO: 1. look for the reason for this again.
      child: new Material(
        color: accentColor,
        shadowColor: const Color(0x44000000),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, bottom: 50.0),
          child: new Column(
            children: <Widget>[

              // rich text enables having two text views with different styles in a single widget
              new RichText(
                text: new TextSpan(
                    text: '',
                    children: [
                      // this text span displays the title of the song
                      new TextSpan(
                          text: 'Song Title\n',
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4.0,
                              height: 1.5
                          )
                      ),

                      new TextSpan(
                        // this text span displays the artist name of the song
                          text: "Artist Name",
                          style: new TextStyle(
                              color: Colors.white.withOpacity(0.75),
                              fontSize: 12.0,
                              letterSpacing: 3.0,
                              height: 1.5
                          )
                      )

                    ]
                ),),

              // here we have the controls i.e. previous, pause and next buttons
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: new Row(
                  children: <Widget>[

                    new Expanded(child: new Container()),

                    new PreviousButton(),

                    new Expanded(child: new Container()),

                    new PlayPauseButton(),

                    new Expanded(child: new Container()),

                    new NextButton(),

                    new Expanded(child: new Container()),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // creating a raw material button so that we can have that splash and highlight effect
    // TODO: 2. look at this again in the video
    return new RawMaterialButton(
      shape: new CircleBorder(),
      fillColor: Colors.white,
      splashColor: lightAccentColor,
      highlightColor: lightAccentColor.withOpacity(0.5),
      elevation: 10.0,
      highlightElevation: 5.0,
      onPressed: (){
        // TODO
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Icon(
          Icons.play_arrow,
          size: 35.0,
          color: darkAccentColor,
        ),
      ),
    );
  }
}


// for the previous button we added Material widget so that splash and highlight can work
class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new IconButton(
      splashColor: lightAccentColor,
      highlightColor: Colors.transparent,
      icon: new Icon(
        Icons.skip_previous,
        color: Colors.white,
        size: 35.0,
      ),
      onPressed: () {
        // TODO
      },
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new IconButton(
      splashColor: lightAccentColor,
      highlightColor: Colors.transparent,
      icon: new Icon(
        Icons.skip_next,
        color: Colors.white,
        size: 35.0,
      ),
      onPressed: (){
        // TODO
      },
    );
  }
}

class CircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return new Rect.fromCircle(
      center: new Offset(size.width / 2, size.height / 2),
      radius: min(size.width, size.height) / 2,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}