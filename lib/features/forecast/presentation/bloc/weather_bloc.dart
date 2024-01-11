import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/features/forecast/presentation/bloc/weather_event.dart';
import 'package:weatherapp/features/forecast/presentation/bloc/weather_state.dart';

import '../../domain/usecases/get_current_weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherInitialState()) {
    on<OnCityChangedEvent>(
      (event, emit) async {
        emit(WeatherLoadingState());
        final result = await _getCurrentWeatherUseCase.execute(event.latitude, event.longitude);
        result.fold(
          (failure) {
            emit(WeatherFailureState(failure.message));
          },
          (data) {
            emit(WeatherFetchState(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
