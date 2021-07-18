import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../services/Utils.dart';



class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen> {

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    Utils utils = new Utils();
    bool status = await utils.hasInternetConnection();
    if(status){
      Navigator.of(context).pushReplacementNamed('/Home');
    }else {
      utils.showAlert(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/img/logoclima.png',
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 30),
              Text("What's the weather?", style: TextStyle(fontSize: 30, color: Colors.black)),
              SizedBox(height: 30),
              CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
              ),

              SizedBox(height: 150),
              Text(
                "Desarrollado por Jaime",
              ),

            ],
          ),
        ),
      ),
    );
  }
}