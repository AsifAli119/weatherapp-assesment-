import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weatherapp/core/constansts/constants.dart';
import 'package:weatherapp/features/forecast/presentation/bloc/weather_event.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  Future<void> _getWeatherForCity(String cityName, BuildContext context) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);
      if (locations.isNotEmpty) {
        double latitude = locations.first.latitude;
        double longitude = locations.first.longitude;
        print('Geocoding success. Latitude: $latitude, Longitude: $longitude');
        context.read<WeatherBloc>().add(OnCityChangedEvent( latitude, longitude));
      } else {
        // Handle case where no location is found for the entered city name
        // You can show an error message or take appropriate action
        print('No location found for $cityName');
      }
    } on Exception catch (e) {
      // Handle exceptions if any occur during geocoding
      print("Geocoding error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1D1E22),
        title: const Text(
          'WEATHER',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                fillColor: const Color(0xffF3F3F3),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
              ),
              // onChanged: (query) {
              //   context.read<WeatherBloc>().add(OnCityChangedEvent());
              // },
              onSubmitted: (cityName){
                _getWeatherForCity(cityName, context);
              },
            ),
            const SizedBox(height: 32.0),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is WeatherFetchState) {
                  return Column(key: const Key('weather_data'), children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.result.cityName,
                          style: const TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                        Image(
                          image: NetworkImage(
                            Url.weatherIcon(
                              state.result.iconCode,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${state.result.main} | ${state.result.description}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Table(
                      defaultColumnWidth: const FixedColumnWidth(150.0),
                      border: TableBorder.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                      children: [
                        TableRow(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Temperature',
                              style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.result.temperature.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ), // Will be change later
                        ]),
                      ],
                    )
                  ]);
                }
                if (state is WeatherFailureState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
