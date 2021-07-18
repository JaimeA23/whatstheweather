import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prueba/src/controller/home_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../services/Utils.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prueba/src/models/clima.dart';
import 'package:prueba/src/helpers/app_config.dart' as config;


class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {
  HomeController _con;

  _HomeWidgetState() : super(HomeController()) {
    _con = controller;
  }

  var flag = 0;
  Clima climafinal;
  var colorportemp = config.Colors().mainColor(1);
  var colorportemp2 = config.Colors().mainColor(1);
  var colorportemp3 = config.Colors().mainColor(1);

  void initState() {
    super.initState();
    buscarclima();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child:
     Scaffold(
      appBar: AppBar(

        backgroundColor: colorportemp,
        centerTitle: true,
        title:Row(
            children: <Widget>[
              Image.asset(
                'assets/img/logoclima.png',
                height: 20,
                alignment: Alignment.topRight,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 5,),
              Text("What's the weather?"),
            ]
        ),

        leading: Container(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              cambiarventana();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: buscarclima,
        child: SingleChildScrollView(
          child: flag==2 ?
               Center(
                child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height:100 ,),
                  Text("Search for a place"),
                  IconButton(
                    icon: Icon(Icons.search,
                    size: 50),
                    onPressed: () {
                      cambiarventana();
                    },
                  ),
                ],)) 
              :flag==0
              ? Center(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height:100 ,),
                    CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
                    )
                  ],))
              :Container(
            width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                maxHeight: double.infinity,
              ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors:[colorportemp.withOpacity(0.9),colorportemp.withOpacity(0.6)],
                    stops: [0.3,0.5],
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter
                ),
                ),
                  child:
                  Column(children: [
                    Container(
                      color: colorportemp.withOpacity(0.5),
                      margin: EdgeInsets.all(40),
                      padding: EdgeInsets.all(20),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Row(
                            children: [
                              Text("${climafinal.title}", style: TextStyle(fontSize: 25, color: Colors.black)),
                              Text(" (${climafinal.type})", style: TextStyle(fontSize: 12, color: Colors.black)),

                            ],
                          ),
                          Container(alignment: Alignment.bottomRight, child: Text("${climafinal.consolidated_weather[0].applicable_date}", style: TextStyle(fontSize: 15, color: Colors.black)),),

                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child:  Image.asset(
                                  'assets/img/${climafinal.consolidated_weather[0].weather_state_abbr}.png',
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),

                              ),
                              Expanded(
                                flex: 4,
                                child: Column(children: [
                                  Text("${climafinal.consolidated_weather[0].weather_state_name} ", style: TextStyle(fontSize: 12, color: Colors.black)),
                                  SizedBox(height: 20,),
                                  Text("${climafinal.consolidated_weather[0].the_temp} C°", style: TextStyle(fontSize: 20, color: Colors.black)),
                                  SizedBox(height: 10,),
                                  Container(alignment: Alignment.center, child: Text("${climafinal.consolidated_weather[0].min_temp} C° - ${climafinal.consolidated_weather[0].max_temp} C°",
                                      style: TextStyle(fontSize: 10, color: Colors.black)),),
                                ],),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column( children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/img/viento.png',
                                        width: 20,
                                        fit: BoxFit.cover,
                                      ),
                                      Transform.rotate(
                                        angle: climafinal.consolidated_weather[0].wind_direction* math.pi / 180,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_upward,
                                            color: Colors.black,
                                          ),
                                          onPressed: null,
                                        ),
                                      ),
                                    ],),
                                  Text("${climafinal.consolidated_weather[0].wind_speed} Km/h",
                                      style: TextStyle(fontSize: 15, color: Colors.black)),
                                  Text("${climafinal.consolidated_weather[0].wind_direction}° ${climafinal.consolidated_weather[0].wind_direction_compass}",
                                      style: TextStyle(fontSize: 10, color: Colors.black)),

                                ],),

                              ),
                              Expanded(
                                flex: 5,
                                child:  Column( children: [
                                  Image.asset(
                                    'assets/img/humedad.png',
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  Text("${climafinal.consolidated_weather[0].humidity}",
                                      style: TextStyle(fontSize: 20, color: Colors.black)),

                                ],),

                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Container(alignment: Alignment.bottomRight, child: Text("Updated time ${DateTime.parse(climafinal.consolidated_weather[0].created).hour} UTC",
                              style: TextStyle(fontSize: 10, color: Colors.black)),),







                        ],
                      ),
                    ),
                    Container(
                      color: colorportemp2.withOpacity(0.5),
                      margin: EdgeInsets.all(40),
                      padding: EdgeInsets.all(20),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Row(
                            children: [
                              Text("${climafinal.title}", style: TextStyle(fontSize: 25, color: Colors.black)),
                              Text(" (${climafinal.type})", style: TextStyle(fontSize: 12, color: Colors.black)),

                            ],
                          ),
                          Container(alignment: Alignment.bottomRight, child: Text("${climafinal.consolidated_weather[1].applicable_date}", style: TextStyle(fontSize: 15, color: Colors.black)),),

                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child:  Image.asset(
                                  'assets/img/${climafinal.consolidated_weather[1].weather_state_abbr}.png',
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),

                              ),
                              Expanded(
                                flex: 4,
                                child: Column(children: [
                                  Text("${climafinal.consolidated_weather[1].weather_state_name} ", style: TextStyle(fontSize: 12, color: Colors.black)),
                                  SizedBox(height: 20,),
                                  Text("${climafinal.consolidated_weather[1].the_temp} C°", style: TextStyle(fontSize: 20, color: Colors.black)),
                                  SizedBox(height: 10,),
                                  Container(alignment: Alignment.center, child: Text("${climafinal.consolidated_weather[1].min_temp} C° - ${climafinal.consolidated_weather[1].max_temp} C°",
                                      style: TextStyle(fontSize: 10, color: Colors.black)),),
                                ],),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column( children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/img/viento.png',
                                        width: 20,
                                        fit: BoxFit.cover,
                                      ),
                                      Transform.rotate(
                                        angle: climafinal.consolidated_weather[1].wind_direction* math.pi / 180,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_upward,
                                            color: Colors.black,
                                          ),
                                          onPressed: null,
                                        ),
                                      ),
                                    ],),
                                  Text("${climafinal.consolidated_weather[1].wind_speed} Km/h",
                                      style: TextStyle(fontSize: 15, color: Colors.black)),
                                  Text("${climafinal.consolidated_weather[1].wind_direction}° ${climafinal.consolidated_weather[1].wind_direction_compass}",
                                      style: TextStyle(fontSize: 10, color: Colors.black)),

                                ],),

                              ),
                              Expanded(
                                flex: 5,
                                child:  Column( children: [
                                  Image.asset(
                                    'assets/img/humedad.png',
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  Text("${climafinal.consolidated_weather[1].humidity}",
                                      style: TextStyle(fontSize: 20, color: Colors.black)),

                                ],),

                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Container(alignment: Alignment.bottomRight, child: Text("Updated time ${DateTime.parse(climafinal.consolidated_weather[1].created).hour} UTC",
                              style: TextStyle(fontSize: 10, color: Colors.black)),),







                        ],
                      ),
                    ),
                    Container(
                      color: colorportemp3.withOpacity(0.5),
                      margin: EdgeInsets.all(40),
                      padding: EdgeInsets.all(20),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Row(
                            children: [
                              Text("${climafinal.title}", style: TextStyle(fontSize: 25, color: Colors.black)),
                              Text(" (${climafinal.type})", style: TextStyle(fontSize: 12, color: Colors.black)),

                            ],
                          ),
                          Container(alignment: Alignment.bottomRight, child: Text("${climafinal.consolidated_weather[2].applicable_date}", style: TextStyle(fontSize: 15, color: Colors.black)),),

                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child:  Image.asset(
                                  'assets/img/${climafinal.consolidated_weather[2].weather_state_abbr}.png',
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),

                              ),
                              Expanded(
                                flex: 4,
                                child: Column(children: [
                                  Text("${climafinal.consolidated_weather[2].weather_state_name} ", style: TextStyle(fontSize: 12, color: Colors.black)),
                                  SizedBox(height: 20,),
                                  Text("${climafinal.consolidated_weather[2].the_temp} C°", style: TextStyle(fontSize: 20, color: Colors.black)),
                                  SizedBox(height: 10,),
                                  Container(alignment: Alignment.center, child: Text("${climafinal.consolidated_weather[2].min_temp} C° - ${climafinal.consolidated_weather[2].max_temp} C°",
                                      style: TextStyle(fontSize: 10, color: Colors.black)),),
                                ],),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column( children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/img/viento.png',
                                        width: 20,
                                        fit: BoxFit.cover,
                                      ),
                                      Transform.rotate(
                                        angle: climafinal.consolidated_weather[2].wind_direction* math.pi / 180,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_upward,
                                            color: Colors.black,
                                          ),
                                          onPressed: null,
                                        ),
                                      ),
                                    ],),
                                  Text("${climafinal.consolidated_weather[2].wind_speed} Km/h",
                                      style: TextStyle(fontSize: 15, color: Colors.black)),
                                  Text("${climafinal.consolidated_weather[2].wind_direction}° ${climafinal.consolidated_weather[2].wind_direction_compass}",
                                      style: TextStyle(fontSize: 10, color: Colors.black)),

                                ],),

                              ),
                              Expanded(
                                flex: 5,
                                child:  Column( children: [
                                  Image.asset(
                                    'assets/img/humedad.png',
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  Text("${climafinal.consolidated_weather[2].humidity}",
                                      style: TextStyle(fontSize: 20, color: Colors.black)),

                                ],),

                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Container(alignment: Alignment.bottomRight, child: Text("Updated time ${DateTime.parse(climafinal.consolidated_weather[2].created).hour} UTC",
                              style: TextStyle(fontSize: 10, color: Colors.black)),),







                        ],
                      ),
                    ),
                  ],)








          ),

        ),
      ),
    )
    );
  }


  void cambiarventana() async {
    Utils utils = new Utils();
    bool conexion = await utils.hasInternetConnection();
    if (conexion) {
      Navigator.of(context).pushReplacementNamed('/Search');
    } else {
      utils.showAlertLowlevel(context);
    }
  }

  Future<void> buscarclima()async {

    Utils utils = new Utils();
    bool conexion = await utils.hasInternetConnection();
    if (conexion) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var city  = prefs.getString('cityusado');
      try{
        Clima climatemporal= await _con.searchclima(city);
        var tempocolorportemp = config.Colors().mainColor(1);
        var tempocolorportemp2 = config.Colors().mainColor(1);
        var tempocolorportemp3 = config.Colors().mainColor(1);

        try{
          tempocolorportemp = await elegircolor(climatemporal.consolidated_weather[0].the_temp);
        }catch(e){

        }
        try{
          tempocolorportemp2 = await elegircolor(climatemporal.consolidated_weather[1].the_temp);
        }catch(e){

        }
        try{
          tempocolorportemp3 = await elegircolor(climatemporal.consolidated_weather[2].the_temp);
        }catch(e){

        }

        setState(() {
          flag= 1;
          climafinal=climatemporal;
          colorportemp=tempocolorportemp;
          colorportemp2=tempocolorportemp2;
          colorportemp3=tempocolorportemp3;
        });

      }catch(e){

        setState(() {
          flag= 2;
        });

      }

    } else {
      utils.showAlertLowlevel(context);
    }

  }






}
