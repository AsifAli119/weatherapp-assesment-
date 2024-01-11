import 'package:equatable/equatable.dart';
import 'package:weatherapp/features/forecast/domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherFetchState extends WeatherState {
  final WeatherEntity result;
  const WeatherFetchState(this.result);

  @override
  List<Object?> get props => [result];
}

class WeatherFailureState extends WeatherState {
  final String message;
  const WeatherFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
