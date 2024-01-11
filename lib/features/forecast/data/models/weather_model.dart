import 'package:weatherapp/features/forecast/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel(
      {required cityName,
      required main,
      required description,
      required iconCode,
      required temperature})
      : super(
          cityName: cityName,
          main: main,
          description: description,
          iconCode: iconCode,
          temperature: temperature,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> e) => WeatherModel(
      cityName: e['name'],
      main: e['weather'][0]['main'],
      description: e['weather'][0]['description'],
      iconCode: e['weather'][0]['icon'],
      temperature: e['main']['temp']);
}
