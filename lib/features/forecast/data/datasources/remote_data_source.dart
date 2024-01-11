
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:weatherapp/features/forecast/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(double latitude, double longitude);
}

class WeatherRemoteDataSourceImp extends WeatherRemoteDataSource {
  final GraphQLClient client;

  WeatherRemoteDataSourceImp({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(double latitude, double longitude) async {
    QueryResult result = await client.query(QueryOptions(
      document: gql("""
        query GetWeather(\$lat: Float!, \$lon: Float!) {
          weather(
            lat: \$lat,
            lon: \$lon,
            source: accuweather,
            units: us,
            windSpeed: kn
          ) {
            currently {
              temperature
              windSpeed
            }
            daily {
              data {
                temperatureMax
                temperatureMin
              }
            }
          }
        }
      """),
      variables: {
        'lat': latitude,
        'lon': longitude,
      },
    ));
    if (result.hasException) {
      throw Exception(result.exception);
    }
    return WeatherModel.fromJson(result.data?['getWeather']);
  }
}