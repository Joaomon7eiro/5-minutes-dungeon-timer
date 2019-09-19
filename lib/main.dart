import 'package:flutter/material.dart';

import './pages/timer_page.dart';
import './pages/home_page.dart';

main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (ctx) => HomePage(),
        TimerPage.routeName: (ctx) => TimerPage()
      },
    );
  }
}
