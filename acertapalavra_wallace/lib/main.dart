import 'package:acertapalavra_wallace/Homepage1.dart';
import 'package:acertapalavra_wallace/Homepage2.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess the Word',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/firstScreen',
      routes: {
        '/firstScreen': (context) => FirstScreen(),
        '/secondScreen': (context) => SecondScreen(),
      },
    );
  }
}
