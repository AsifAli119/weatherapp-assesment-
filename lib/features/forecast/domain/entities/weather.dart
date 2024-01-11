class WeatherEntity {
  final String cityName;
  final String main;
  final String description;
  final String iconCode;
  final double temperature;

  const WeatherEntity(
      {required this.cityName,
      required this.main,
      required this.description,
      required this.iconCode,
      required this.temperature});

  List<Object?> get props => [
        cityName,
        main,
        description,
        iconCode,
        temperature,
      ];
}
