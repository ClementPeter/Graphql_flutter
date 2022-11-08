import 'package:flutter/foundation.dart';
import 'package:graphql_app/schema/add_Task_schema.dart';
import 'package:graphql_app/schema/urlEndPoint.dart';
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
        true; //True;Signifies that loading operation is happening in out app
    _response = "Please wait...";

    notifyListeners(); //Used to trigger change update to the provider class

    //Get our GraphQl client
    ValueNotifier<GraphQLClient> client = _point.getClient();

    //Mutate changes into out Graphql Client
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
      print(result.exception); //if there is error; print the error...else...
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        // print("result from 1st if");
        // print(result.exception);

        //if the error is due to internet connection
        _response = "Internet is not Found";
      } else {
        print("result from 2nd if");
        print(result.exception);
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      print(result.data);
      _status =
          false; //False,Signifies that No loading opeation is happening in out app
      _response = "Task was added successfully";
      notifyListeners();
    }
  }

  void clear() {
    _response = "";
    notifyListeners();
  }
}
