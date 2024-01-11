abstract class Url {
  static const String baseUrl = 'https://weathermachine.io';
  static const String apikey = 'ab2c9ddb81a1f22d3abf2e2e72a2be80';

  static String currentWeatherByName() =>
      '$baseUrl/api?apikey=$apikey';

  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
