import 'package:dartz/dartz.dart';
import 'package:weatherapp/features/forecast/domain/entities/weather.dart';
import 'package:weatherapp/features/forecast/domain/reposotries/weather_repo.dart';

import '../../../../core/error/failure.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepo weatherRepo;
  GetCurrentWeatherUseCase(this.weatherRepo);

  Future<Either<Failure, WeatherEntity>> execute(double latitude, double longitude) {
    return weatherRepo.getWeather(latitude, longitude);
  }
}
