import 'package:graphql_flutter/graphql_flutter.dart';

import '../constansts/constants.dart';


class GraphQlConfig {

  GraphQlConfig();

  HttpLink get httpLink => HttpLink(Url.currentWeatherByName());

  GraphQLClient clientToQuery() => GraphQLClient(link: httpLink, cache: GraphQLCache());
}
