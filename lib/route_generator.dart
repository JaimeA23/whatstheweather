import 'package:flutter/material.dart';
import 'package:prueba/src/page/splash.dart';
import 'package:prueba/src/page/home.dart';
import 'package:prueba/src/page/search.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/Home':
        return MaterialPageRoute(builder: (_) => HomeWidget());
      case '/Search':
        return MaterialPageRoute(builder: (_) => SearchWidget());
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
