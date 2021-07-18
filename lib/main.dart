import 'package:dnd_dices/about_screen.dart';
import 'package:dnd_dices/main_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

StreamController<bool> isLightTheme = StreamController();

bool isCheatActive = false;
bool isFirstTimeOnAboutPage = true;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return StreamBuilder<bool>(
      initialData: currentTheme,
      stream: isLightTheme.stream,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'DnD dices',
          theme: snapshot.data
              ? ThemeData(
                  backgroundColor: Colors.orange[200],
                  primaryColor: Colors.orange[200],
                  accentColor: Colors.brown,
                )
              : ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: MyHomePage(title: 'Your favorite dices'),
          routes: {
            AboutUsScreen().routeName: (ctx) => AboutUsScreen(),
          },
        );
      },
    );
  }
}
