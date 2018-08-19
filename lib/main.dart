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
                  child: new RadialSeekBar(
                    progressPercent: 0.2,
                    thumbPosition: 0.2,
                    child: ClipOval(
                      clipper: new CircleClipper(),
                      child: new Image.network(
                        demoPlaylist.songs[0].albumArtUrl,
                        fit: BoxFit.cover,
                      ),
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

class RadialSeekBar extends StatefulWidget {
  final double trackWidth;
  final Color trackColor;
  final double progressWidth;
  final Color progressColor;
  final double progressPercent;
  final double thumbSize;
  final Color thumbColor;
  final double thumbPosition;
  final Widget child;

  RadialSeekBar({
    this.trackWidth = 3.0,
    this.trackColor = Colors.grey,
    this.progressWidth = 5.0,
    this.progressColor = Colors.black,
    this.progressPercent = 0.0,
    this.thumbColor = Colors.black,
    this.thumbSize = 10.0,
    this.thumbPosition = 0.0,
    this.child
});

  @override
  _RadialSeekBarState createState() => _RadialSeekBarState();
}

class _RadialSeekBarState extends State<RadialSeekBar> {
  @override
  Widget build(BuildContext context) {
    return new CustomPaint(
      foregroundPainter: new RadialSeekBarPainter(
        trackWidth: widget.trackWidth,
        trackColor:  widget.trackColor,
        progressWidth: widget.progressWidth,
        progressColor: widget.progressColor,
        progressPercent: widget.progressPercent,
        thumbSize: widget.thumbSize,
        thumbColor: widget.thumbColor,
        thumbPosition: widget.thumbPosition
      ),
      child: widget.child,
    );
  }
}

class RadialSeekBarPainter extends CustomPainter{
  final double trackWidth;
  final Color trackColor;
  final Paint trackPaint;

  final double progressWidth;
  final Paint progressPaint;
  final double progressPercent;
  final Color progressColor;

  final double thumbSize;
  final Paint thumbPaint;
  final double thumbPosition;
  final Color thumbColor;


  RadialSeekBarPainter({
    @required this.trackWidth,

    @required this.trackColor,

    @required this.progressWidth,

    @required this.progressPercent,

    @required this.progressColor,

    @required this.thumbSize,

    @required this.thumbPosition,

    @required this.thumbColor

}) : trackPaint = new Paint()
  ..color = trackColor
  ..style = PaintingStyle.stroke
  ..strokeWidth = trackWidth,

  progressPaint = new Paint()
  ..color = progressColor
  ..style = PaintingStyle.stroke
  ..strokeWidth = progressWidth
  ..strokeCap = StrokeCap.round,

  thumbPaint = new Paint()
  ..color = thumbColor
  ..style = PaintingStyle.fill;


  @override
  void paint(Canvas canvas, Size size) {
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height)/2;

    //Paint track
    canvas.drawCircle(
      center,
      radius,
      trackPaint
    );

    // Paint progress

    final progressAngle = 2 * pi * progressPercent;

    canvas.drawArc(
      new Rect.fromCircle(
        center: center,
        radius: radius
      ),
      -pi/2,
      progressAngle,
      false,
      progressPaint
    );

    //paint thumb
    final thumbAngle = 2 * pi * thumbPosition - (pi / 2);
    final thumbX = cos(thumbAngle) * radius;
    final thumbY = sin(thumbAngle) * radius;
    final thumbCenter = new Offset(thumbX, thumbY) + center;

    final thumbRadius = thumbSize / 2.0;
    canvas.drawCircle(
      thumbCenter,
      thumbRadius,
      thumbPaint
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }


}





