import 'package:flutter/foundation.dart';
import 'package:graphql_app/schema/add_task_schema.dart';
import 'package:graphql_app/schema/url_end_point.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

//Provider class for Adding Task to Graphql
class AddTaskProvider extends ChangeNotifier {
  //getters
  bool get getStatus => _status;
  String get getResponse => _response;

  //setters
  bool _status = false; //false;  means nothing is happpening in our app atm
  String _response = ""; //stores response message

  final EndPoint _point = EndPoint(); //Create EndPoint Instance

  //method to add task
  //the data passed to addTask() eventually gets into the GraphQl client via ValurNotifier
  void addTask({String? task, String? status}) async {
    _status =
        true; //True;Signifies that loading operation is happening in our app
    _response = "Please wait...";

    notifyListeners(); //Used to trigger change update to the provider class

    //Get our GraphQl client/EndPoint
    ValueNotifier<GraphQLClient> client = _point.getClient();

    //Mutate changes into our Graphql Client
    QueryResult result = await client.value.mutate(
      MutationOptions(
        document: gql(AddTaskSchema.addTaskJson),
        //we pass in our needed SCHEMA variables (AddTaskSchema atm) into the variable --This is synomynous to creating a POST req.
        variables: {
          'task': task,
          'status': status,
        },
      ),
    );

    //checking for errors
    if (result.hasException) {
      // print(result.exception); //if there is error; print the error
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response =
            "Internet Access not Avalaible"; //if the error is due to internet connection
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      // print(result.data);
      _status =
          false; //False,Signifies that No loading opeation is happening in out app
      _response = "Task was added successfully";
      notifyListeners();
    }
  }

  //Function to clear the response
  void clear() {
    _response = "";
    notifyListeners();
  }
}
