import 'dart:async';

import 'package:flutter/material.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class TimerPage extends StatefulWidget {
  static const routeName = '/timer-page';

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const totalTime = 300;

  bool _timerIsRunning = false;
  bool _hasStarted = false;
  bool _hasBegin = false;

  Timer _timer;
  int _start = totalTime;

  static AudioCache storytellerPlayer = AudioCache(prefix: 'raw/');
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  String get timerText {
    var timeData = Duration(seconds: _start);
    return '${timeData.inMinutes}:${(timeData.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void handleTimer(Timer timer) {
    setState(() {
      switch (_start) {
        case 0:
          storytellerPlayer.clearCache();
          _assetsAudioPlayer.dispose();
          timer.cancel();
          return;
        case 240:
          storytellerPlayer.play('welcome.mp3');
          break;
        case 180:
          storytellerPlayer.play('welcome.mp3');
          break;
        case 120:
          storytellerPlayer.play('welcome.mp3');
          break;
        case 60:
          storytellerPlayer.play('welcome.mp3');
          break;
        case 30:
          storytellerPlayer.play('welcome.mp3');
          break;
        default:
      }
      _start--;
    });
  }

  void startTimer() {
    if (!_hasBegin) {
      setState(() {
        _hasBegin = true;
      });
      Future.delayed(Duration(seconds: 4), () {
        startTimer();
      });
      return;
    }
    if (!_hasStarted) {
      _assetsAudioPlayer.open(AssetsAudio(
        asset: "main_audio.mp3",
        folder: "assets/raw/",
      ));
    }
    _assetsAudioPlayer.play();

    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) => handleTimer(timer));

    setState(() {
      _hasStarted = true;
      _timerIsRunning = true;
    });
  }

  void stopTimer() {
    _timer.cancel();
    setState(() {
      _timerIsRunning = false;
    });
    _assetsAudioPlayer.pause();
  }

  void restartTimer() {
    _start = totalTime;
    _timer.cancel();
    setState(() {
      _timerIsRunning = false;
      _hasStarted = false;
      _hasBegin = false;
    });
    _assetsAudioPlayer.pause();
    _assetsAudioPlayer.dispose();
  }

  @override
  void dispose() {
    _timer.cancel();
    _assetsAudioPlayer.pause();
    _assetsAudioPlayer.dispose();
    storytellerPlayer.clearCache();
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
                        if (_hasStarted)
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  timerText,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 140),
                                ),
                              ],
                            ),
                          )
                        else if (_hasBegin)
                          SizedBox(
                            width: 250.0,
                            child: ScaleAnimatedTextKit(
                                duration: Duration(seconds: 4),
                                isRepeatingAnimation: false,
                                onTap: () {
                                  print("Tap Event");
                                },
                                text: ["3", "2", "1", 'GO!'],
                                textStyle: TextStyle(
                                  fontSize: 140,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                alignment: AlignmentDirectional.topStart),
                          )
                        else
                          Text(''),
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
                  if (_hasStarted)
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
