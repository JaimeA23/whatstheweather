
import 'package:prueba/src/models/weather.dart';
class Clima {
  int woeid;
  String title;
  String type;
  List<Weather> consolidated_weather;
  Clima.init();

  Clima({
    this.woeid,
    this.title,
    this.type,
});

  Clima.fromJSON(Map<String, dynamic> jsonMap)
      : woeid = jsonMap['woeid'].toInt(),
        title = jsonMap['title'],
        type = jsonMap['location_type'],
        consolidated_weather = jsonMap['consolidated_weather'] != null
            ? List.from(jsonMap['consolidated_weather'])
            .map((element) => Weather.fromJSON(element))
            .toList()
            : [];



  Map<String, dynamic> toMap() {
    return {
      'woeid': woeid,
      'title': title,
      'type': type
    };
  }

}