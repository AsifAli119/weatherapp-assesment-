import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/container_injection.dart';
import 'package:weatherapp/features/forecast/presentation/bloc/weather_bloc.dart';
import 'package:weatherapp/features/forecast/presentation/screens/weather_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => locator<WeatherBloc>(),
      )
    ], child: const MaterialApp(home: WeatherPage()));
  }
}
