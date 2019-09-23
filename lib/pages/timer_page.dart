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
  static const totalTime = 300; // 5min

  Timer _timer;

  bool _timerIsRunning = false;
  bool _timerHasStarted = false;
  bool _countdownHasStarted = false;

  int _dungeonCurrentTime = totalTime;

  static AudioCache storytellerPlayer = AudioCache(prefix: 'raw/');
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  String get timerText {
    var timeData = Duration(seconds: _dungeonCurrentTime);
    return '${timeData.inMinutes}:${(timeData.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void handleTimer(Timer timer) {
    setState(() {
      switch (_dungeonCurrentTime) {
        case 0:
          storytellerPlayer.play('welcome.mp3');
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
        case 10:
          storytellerPlayer.play('welcome.mp3');
          break;
        default:
      }
      _dungeonCurrentTime--;
    });
  }

  void startTimer() {
    if (!_countdownHasStarted) {
      setState(() {
        _countdownHasStarted = true;
      });
      Future.delayed(Duration(seconds: 1), () {
        _assetsAudioPlayer.open(AssetsAudio(
          asset: "main_audio.mp3",
          folder: "assets/raw/",
        ));
      });
      Future.delayed(Duration(seconds: 4), () {
        startTimer();
      });
      return;
    }
    _assetsAudioPlayer.play();

    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) => handleTimer(timer));

    setState(() {
      _timerHasStarted = true;
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
    _dungeonCurrentTime = totalTime;
    restartPlayers();
    setState(() {
      _timerIsRunning = false;
      _timerHasStarted = false;
      _countdownHasStarted = false;
    });
  }

  void restartPlayers() {
    _timer.cancel();
    _assetsAudioPlayer.stop();
    _assetsAudioPlayer.dispose();
    storytellerPlayer.clearCache();
  }

  @override
  void dispose() {
    restartPlayers();
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
                        if (_timerHasStarted)
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
                        else if (_countdownHasStarted)
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
                                alignment: AlignmentDirectional.center),
                          )
                        else
                          Text(''),
                        if (!_timerHasStarted && _countdownHasStarted)
                          Text('')
                        else if (!_timerIsRunning)
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
                  if (_timerHasStarted)
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
