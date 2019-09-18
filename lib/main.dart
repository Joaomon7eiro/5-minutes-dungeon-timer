import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Timer _timer;
  bool _timerIsRunning = false;
  int _start = 30;

  String get timerText {
    var timeData = Duration(seconds: _start);
    return '${timeData.inMinutes}:${timeData.inSeconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
        if (_start < 1) {
          timer.cancel();
        } else {
          _start--;
        }
      }),
    );

    setState(() {
      _timerIsRunning = true;
    });
  }

  void stopTimer() {
    _timer.cancel();
    setState(() {
      _timerIsRunning = false;
    });
  }

  void restartTimer() {
    _start = 30;
    _timer.cancel();
    setState(() {
      _timerIsRunning = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/dungeon_background.jpg',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.9,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          timerText,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 140),
                        ),
                        if (!_timerIsRunning)
                          FlatButton(
                            onPressed: startTimer,
                            child: Icon(
                              Icons.play_arrow,
                              size: 180,
                              color: Colors.white,
                            ),
                          )
                        else
                          FlatButton(
                            onPressed: stopTimer,
                            child: Icon(
                              Icons.pause,
                              size: 180,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: restartTimer,
                      color: Colors.white,
                      iconSize: 50,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
