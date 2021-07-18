import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';



class Utils{

  Future<bool> hasInternetConnection() async {
    int timeout = 10;
    try {
      http.Response response = await http.get(Uri.parse('https://www.google.com')).
      timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('There are connection problems'),
          content: Text("Do you want to try again?"),
          actions: <Widget>[
            FlatButton(
              child: Text("NO"),
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("YES"),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/Splash');
              },
            ),
          ],
        );
      },
    );
  }

  showAlertLowlevel(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('There are connection problems'),
          content: Text("check your connection please"),
        );
      },
    );
  }



}