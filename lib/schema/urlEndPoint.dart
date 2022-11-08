import 'package:flutter/foundation.dart' show ValueNotifier;
import 'package:graphql_app/utility/url.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

//This class connects our App to our GraphUrl EndPoint with the help of ValueNotifier from Flutter
//This is a good way of doing it cos ur backed stuff would be isolated from the UI
class EndPoint {
  ValueNotifier<GraphQLClient> getClient(String token) {
    ValueNotifier<GraphQLClient> _client = ValueNotifier(
      GraphQLClient(
        link: HttpLink(endpointUrl),
        cache: GraphQLCache(
          store: HiveStore(),
        ),
      ),
    );
    return _client;
  }
}


