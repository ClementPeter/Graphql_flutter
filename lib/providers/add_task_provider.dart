import 'package:flutter/foundation.dart';

//Provider class for Adding Task to Graphql
class AddTaskProvider extends ChangeNotifier {
  //getters
  bool get status => _status;
  String get response => _response;

  //setters
  bool _status = false; //false means nothing is happpening atm
  String _response = ""; //stores response message

  //method to add tas
  void addTask() async {}
}
