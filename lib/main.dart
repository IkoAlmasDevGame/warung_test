import 'package:flutter/material.dart';
import 'package:warung_test/Lobby.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Warung Test",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: HomeLobby(),
    );
  }
}
