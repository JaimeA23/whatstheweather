import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:prueba/src/models/clima.dart';
import 'package:prueba/src/helpers/app_config.dart' as config;


class HomeController extends ControllerMVC {

  Future<Clima> searchclima(texto) async{
    Clima climafinal;
    http.Response response = await http.get(Uri.parse('https://www.metaweather.com/api/location/'+texto));

    var body = json.decode(utf8.decode(response.bodyBytes));

    climafinal=Clima.fromJSON(body);
    return climafinal;
  }

}

elegircolor(temp){

  var colorelegido;

  if(temp>=40){
    colorelegido = config.Colors().secondColor(1);
  }
  else if (temp>=30 && temp<40){
    colorelegido = config.Colors().accentColor(1);
  }
  else if (temp>=20 && temp<30){
    colorelegido = config.Colors().mainDarkColor(1);
  }
  else if (temp>=10 && temp<20){
    colorelegido = config.Colors().secondDarkColor(1);
  }
  else if (temp>=0 && temp<10){
    colorelegido = config.Colors().accentDarkColor(1);
  }
  else if (temp<0){
    colorelegido = config.Colors().indicatorColor(1);
  }
  else {
    colorelegido = config.Colors().mainColor(1);
  }

  return colorelegido;

}
