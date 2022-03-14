import 'package:flutter/material.dart';

void main() {
  runApp(const TVShowsApp());
}

class TVShowsApp extends StatelessWidget {
  const TVShowsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Container(color: Colors.deepPurpleAccent),
    );
  }
}
