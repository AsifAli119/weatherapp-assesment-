import 'package:dartz/dartz.dart';
import 'package:weatherapp/core/error/failure.dart';
import 'package:weatherapp/features/forecast/domain/entities/weather.dart';

abstract class WeatherRepo {
  Future<Either<Failure, WeatherEntity>> getWeather(double latitude, double longitude);
}
