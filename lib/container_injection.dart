import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'core/graphql_config/graphql_config.dart';
import 'features/forecast/data/datasources/remote_data_source.dart';
import 'features/forecast/data/reposotries/weathter_repo_impl.dart';
import 'features/forecast/domain/reposotries/weather_repo.dart';
import 'features/forecast/domain/usecases/get_current_weather.dart';
import 'features/forecast/presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator
      .registerFactory(() => WeatherBloc(locator<GetCurrentWeatherUseCase>()));

  // usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  // repository
  locator.registerLazySingleton<WeatherRepo>(
    () => WeatherRepoImpl(weatherRemoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImp(
      client: locator<GraphQLClient>(),
    ),
  );

  // external
  locator.registerLazySingleton<GraphQLClient>(
      () => GraphQlConfig().clientToQuery());
}
