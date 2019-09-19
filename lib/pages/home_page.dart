import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './timer_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/home_bg.jpg',
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          FlatButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, TimerPage.routeName);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'ENTRAR NA MASMORRA',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return _BottomSheet();
                  });
            },
            child: Column(
              children: <Widget>[
                Text(
                  'NARRADOR',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Épico',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.all(10),
            onPressed: () {},
            child: Text(
              'Dragão',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          FlatButton(
            padding: EdgeInsets.all(10),
            onPressed: () {},
            child: Text(
              'Bebê',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          FlatButton(
            padding: EdgeInsets.all(10),
            onPressed: () {},
            child: Text(
              'Mestre das Masmorras',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          FlatButton(
            padding: EdgeInsets.all(10),
            onPressed: () {},
            child: Text(
              'Épico',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
