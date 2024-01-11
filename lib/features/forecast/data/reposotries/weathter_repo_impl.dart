import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:weatherapp/core/error/failure.dart';
import 'package:weatherapp/features/forecast/data/datasources/remote_data_source.dart';
import 'package:weatherapp/features/forecast/domain/entities/weather.dart';
import 'package:weatherapp/features/forecast/domain/reposotries/weather_repo.dart';

class WeatherRepoImpl extends WeatherRepo {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepoImpl({required this.weatherRemoteDataSource});
  @override
  Future<Either<Failure, WeatherEntity>> getWeather(double latitude, double longitude) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(latitude, longitude);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure("An error occured"));
    } on SocketException {
      return const Left(NetworkFailure("Failed to connect to the network"));
    }
  }
}
