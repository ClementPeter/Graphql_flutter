import 'package:flutter/foundation.dart';
import 'package:graphql_app/schema/get_task_schema.dart';
import 'package:graphql_app/schema/url_end_point.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

//Provider class for Get Task to Graphql
class GetTaskProvider extends ChangeNotifier {
  //getters
  bool get getStatus => _status;
  String get getResponse => _response;

  //setters
  bool _status = false; //false;  means nothing is happpening in our app atm
  String _response = ""; //stores response message
  dynamic _list = [];  //Stores result from backend API as List 

  final EndPoint _point = EndPoint(); //Create EndPoint Instance

  //method to get task
  //the data passed to addTask() eventually gets into the GraphQl client via Value Notifier
  void getTask() async {
    //Get our GraphQl client
    ValueNotifier<GraphQLClient> client = _point.getClient();

    //Query changes into our Graphql Client
    QueryResult result = await client.value.query(
      QueryOptions(
        document: gql(GetTaskSchema.getTaskJson),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    //checking for errors
    if (result.hasException) {
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response =
            "Internet Access not Avalaible"; //if the error is due to internet connection
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      //print(result.data);
      _status =
          false; //False,Signifies that No loading opeation is happening in out app

      _list = result.data;
      notifyListeners();
    }
  }

  //To avaid duplicate results from getTask ; We create a seperate function to get our task from the updated _list directl and check if its null
  dynamic getResponseData() {
    if (_list.isNotEmpty) {
      final data = _list;

      return data['getTodos'] ?? {};
    } else {
      return {};
    }
  }

  //Function to clear the response
  void clear() {
    _response = "";
    notifyListeners();
  }
}
