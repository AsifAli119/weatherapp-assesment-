import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object?> get props => [];
}

class WeatherInitialEvent extends WeatherEvent {}

class OnCityChangedEvent extends WeatherEvent {
  final double latitude;
  final double longitude;
  const OnCityChangedEvent( this.latitude, this.longitude);

  @override
  List<Object?> get props => [latitude, longitude];
}
