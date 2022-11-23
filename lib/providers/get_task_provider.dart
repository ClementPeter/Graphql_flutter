import 'package:flutter/foundation.dart';
import 'package:graphql_app/schema/add_Task_schema.dart';
import 'package:graphql_app/schema/get_task_schema.dart';
import 'package:graphql_app/schema/urlEndPoint.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

//Provider class for Get Task to Graphql
class GetTaskProvider extends ChangeNotifier {
  //getters
  bool get getStatus => _status;
  String get getResponse => _response;

  //setters
  bool _status = false; //false;  means nothing is happpening in our app atm
  String _response = ""; //stores response message
  dynamic _list = [];

  final EndPoint _point = EndPoint(); //Create EndPoint Instance

  //method to add task
  //the data passed to addTask() eventually gets into the GraphQl client via ValurNotifier
  void getTask() async {
    //Get our GraphQl client
    ValueNotifier<GraphQLClient> client = _point.getClient();

    //Mutate changes into our Graphql Client
    QueryResult result = await client.value.mutate(
      MutationOptions(
        document: gql(GetTaskSchema.getTaskJson),
      ),
    );

    //checking for errors
    if (result.hasException) {
      print(result.exception); //if there is error; print the error...else...
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        // print("result from 1st if");
        // print(result.exception);
        _response =
            "Internet Access not Avalaible"; //if the error is due to internet connection
      } else {
        //  print("result from 2nd if");
        print(result.exception);
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      print(result.data);
      _status =
          false; //False,Signifies that No loading opeation is happening in out app
      // _response = "Task was added successfully";
      _list = result.data;
      notifyListeners();
    }
  }

  //To avaid duplicate results from getTask ; We create a seperate function to get our task from the updated _list directlyand check if its null
  dynamic getResponseData() {
    if (_list.isNotEmpty) {
      final data = _list;
      // print(data);
      print("========================================");
      print(data["getTodos"]);
      //return data['getToDos'] ?? {};
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
