
class Weather {
  int id;
  String weather_state_name;
  String weather_state_abbr;
  String wind_direction_compass;
  String applicable_date;
  String created;
  double min_temp;
  double max_temp;
  double the_temp;
  double wind_speed;
  double wind_direction;
  double air_pressure;
  double humidity;
  Weather.init();

  Weather({
    this.id,
    this.weather_state_name,
    this.weather_state_abbr,
    this.wind_direction_compass,
    this.applicable_date,
    this.created,
    this.min_temp,
    this.max_temp,
    this.the_temp,
    this.wind_speed,
    this.wind_direction,
    this.air_pressure,
    this.humidity,
});

  Weather.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'].toInt(),
        weather_state_name = jsonMap['weather_state_name'],
        weather_state_abbr = jsonMap['weather_state_abbr'],
        wind_direction_compass = jsonMap['wind_direction_compass'],
        applicable_date = jsonMap['applicable_date'],
        created=jsonMap['created'],
        min_temp = double.parse((jsonMap['min_temp']).toStringAsFixed(2)),
        max_temp =  double.parse((jsonMap['max_temp']).toStringAsFixed(2)),
        the_temp =  double.parse((jsonMap['the_temp']).toStringAsFixed(2)),
        wind_speed =  double.parse((jsonMap['wind_speed']).toStringAsFixed(2)),
        wind_direction =  double.parse((jsonMap['wind_direction']).toStringAsFixed(2)),
        air_pressure =  double.parse((jsonMap['air_pressure']).toStringAsFixed(2)),
        humidity =  double.parse((jsonMap['humidity']).toStringAsFixed(2));



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weather_state_name': weather_state_name,
      'weather_state_abbr': weather_state_abbr,
      'wind_direction_compass': wind_direction_compass,
      'applicable_date': applicable_date,
      'min_temp': min_temp,
      'max_temp': max_temp,
      'the_temp': the_temp,
      'wind_speed': wind_speed,
      'wind_direction': wind_direction,
      'air_pressure': air_pressure,
      'humidity': humidity,
      'created':created,
    };
  }

}