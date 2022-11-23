import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graphql_app/providers/add_task_provider.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _taskController =
      TextEditingController(); //Helps us to track text input in our TextField

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add New Todo'),
      ),

      //Custom scroll view provides a cool animation look when we scroll
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text('Add your first todo'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: _taskController,
                      decoration: const InputDecoration(
                        labelText: 'Todo Task',
                      ),
                    ),
                  ),
                  //Add/Save Task Button - Consumer helps to inject the provider into the button in order for the provider to be trigger
                  Consumer<AddTaskProvider>(
                    builder: (context, task, child) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (task.getResponse != '') {
                          //Show snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(task.getResponse),
                            ),
                          );
                          _taskController
                              .clear(); //Clear the text field after adding task succesfully
                        
                          //Check the Snack bar message to see if it tallies with "endsWith" the pop the screen off
                          if (task.getResponse.endsWith("fully") == true) {
                            Navigator.pop(context);
                            task.clear();
                          }
                        }
                      });
                      return InkWell(
                        //if task.status ==true (meaning Nothing is happening) return null; else Add task from textField to addTask Provider method
                        onTap: task.getStatus == true
                            ? null
                            : () {
                                //print(_task.text);
                                if (_taskController.text.isNotEmpty) {
                                  task.addTask(
                                    task: _taskController.text.trim(),
                                    status: 'Pending',
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Enter a Task'),
                                    ),
                                  );
                                }
                              },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: task.getStatus == true
                                ? Colors.grey
                                : Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            task.getStatus == true ? 'Loading...' : 'Save Task',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
