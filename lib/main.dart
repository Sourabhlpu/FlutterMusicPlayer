import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_music_player/bottom_controls.dart';
import 'package:flutter_music_player/songs.dart';
import 'package:flutter_music_player/theme.dart';
import 'package:fluttery/gestures.dart';

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
            child: new RadialSeekBar(
              child: new Container(
                color: accentColor,
                child: new Image.network(
                  demoPlaylist.songs[0].albumArtUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
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

  final Widget child;

  RadialSeekBar({
    this.child,
  });

  @override
  RadialSeekBarState createState() {
    return new RadialSeekBarState();
  }
}

class RadialSeekBarState extends State<RadialSeekBar> {

  double _seekPercent = 0.25;
  PolarCoord _startDragCoord;
  double _startDragPercent;
  double _currentDragPercent;

  void _onDragStart(PolarCoord startCoord) {
    print('start drag');
    _startDragCoord = startCoord;
    _startDragPercent = _seekPercent;
  }

  void _onDragUpdate(PolarCoord updateCoord) {
    print('update drag');
    final dragAngle = updateCoord.angle - _startDragCoord.angle;
    final dragPercent = dragAngle / (2 * pi);

    setState(() => _currentDragPercent = (_startDragPercent + dragPercent) % 1.0);
  }

  void _onDragEnd() {
    setState(() {
      _seekPercent = _currentDragPercent;
      _currentDragPercent = null;
      _startDragCoord = null;
      _startDragPercent = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new RadialDragGestureDetector(
      onRadialDragStart: _onDragStart,
      onRadialDragUpdate: _onDragUpdate,
      onRadialDragEnd: _onDragEnd,
      child: new Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: new Center(
          child: new Container(
            width: 140.0,
            height: 140.0,
            child: new RadialProgressBar(
              progressPercent: _currentDragPercent ?? _seekPercent,
              thumbPosition: _currentDragPercent ?? _seekPercent,
              trackWidth: 3.0,
              trackColor: const Color(0xFFDDDDDD),
              progressWidth: 6.0,
              progressColor: accentColor,
              thumbColor: lightAccentColor,
              thumbSize: 10.0,
              innerPadding: const EdgeInsets.all(10.0),
              child: new ClipOval(
                clipper: new CircleClipper(),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RadialProgressBar extends StatefulWidget {
  final double trackWidth;
  final Color trackColor;
  final double progressWidth;
  final Color progressColor;
  final double progressPercent;
  final double thumbSize;
  final Color thumbColor;
  final double thumbPosition;
  final EdgeInsets outerPadding;
  final EdgeInsets innerPadding;
  final Widget child;

  RadialProgressBar({
    this.trackWidth = 3.0,
    this.trackColor = Colors.grey,
    this.progressWidth = 5.0,
    this.progressColor = Colors.black,
    this.progressPercent = 0.0,
    this.thumbColor = Colors.black,
    this.thumbSize = 10.0,
    this.thumbPosition = 0.0,
    this.outerPadding = const EdgeInsets.all(0.0),
    this.innerPadding = const EdgeInsets.all(0.0),
    this.child
});

  @override
  _RadialProgressBarState createState() => _RadialProgressBarState();
}


class _RadialProgressBarState extends State<RadialProgressBar> {

  EdgeInsets _insetsForPainter()
  {
    // Make room for the painted track, progress, and thumb. We divide by 2.0
    // because we want to allow flush painting against the track, so we only
    // need to account the thickness outside the track, not inside.

    final outerThickness = max(
        widget.trackWidth,
      max(
          widget.progressWidth,
          widget.thumbSize
      )
    ) / 2.0;

    return new EdgeInsets.all(outerThickness);
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: widget.outerPadding,
      child: new CustomPaint(
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

        child: new Padding(
          padding: _insetsForPainter() + widget.innerPadding,
          child: widget.child,
        ),
      ),
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

    final outerThickness = max(trackWidth, max(progressWidth, thumbSize));
    Size constrainedSize = new Size(
      size.width - outerThickness,
      size.height - outerThickness
    );

    final center = new Offset(size.width / 2, size.height / 2);
    final radius = min(constrainedSize.width, constrainedSize.height)/2;

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





