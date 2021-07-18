import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:prueba/src/helpers/app_config.dart' as config;
import 'package:prueba/route_generator.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  runApp(
    Phoenix(
      child:  MyApp(),
    ),
  );
}

class MyApp extends AppMVC {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: "Tu clima",
      initialRoute: '/Splash',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColorDark: Colors.grey,
        fontFamily: 'Poppins',
        primaryColor: config.Colors().mainColor(1),
        accentColor: config.Colors().accentColor(1),
        focusColor: config.Colors().secondColor(1),
        hintColor: config.Colors().textColorDark(1),
        scaffoldBackgroundColor: config.Colors().scaffoldColor(1),
        secondaryHeaderColor: config.Colors().secondaryHeaderColor(1),
        indicatorColor: config.Colors().indicatorColor(1),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
              color: config.Colors().textColorDark(1)),
          headline2: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().textColorDark(1)),
          headline3: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().textColorDark(1)),
          headline4: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().textColorDark(1)),
          headline5: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().textColorDark(1)),
          subtitle1: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: config.Colors().textColorDark(1)),
          bodyText1: TextStyle(
              fontSize: 12.0, color: config.Colors().textColorDark(1)),
          bodyText2: TextStyle(
              fontSize: 14.0, color: config.Colors().textColorDark(1)),
          caption: TextStyle(
              fontSize: 12.0, color: config.Colors().textColorDark(1)),
        ),
      ),
    );
  }
}






