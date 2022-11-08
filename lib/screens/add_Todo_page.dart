import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graphql_app/providers/add_task_provider.dart';

class AddTodoPage extends StatefulWidget {
  //const AddTodoPage({super.key, required this.title});
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  MaterialBanner _showMaterialBanner(BuildContext context) {
    return MaterialBanner(
        content: Text('Hello, I am a Material Banner'),
        leading: Icon(Icons.error),
        padding: EdgeInsets.all(15),
        backgroundColor: Colors.lightGreenAccent,
        contentTextStyle: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Agree',
              style: TextStyle(color: Colors.purple),
            ),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.purple),
            ),
          ),
        ]);
  }

  final TextEditingController _task =
      TextEditingController(); //Helps us to track text input in our TextField

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add New Todo'),
      ),

      //Custome scroll view provides a cool animation look when we scroll
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              //height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text('Add your first todo'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: _task,
                      decoration: const InputDecoration(
                        labelText: 'Todo Task',
                      ),
                    ),
                  ),
                  //Add Task Button - Consumer helps to inject the provider into the button in order for the provider to be trigger
                  Consumer<AddTaskProvider>(
                    builder: (context, task, child) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        if (task.getResponse != '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(task.getResponse)));
                          task.clear();
                        }
                      });
                      return GestureDetector(
                        //if task.status ==true (meaning Nothing is happening) return null; else Add task from textField to addTask Provider method
                        onTap: task.getStatus == true
                            ? null
                            : () {
                                //print(_task.text);
                                if (_task.text.isNotEmpty) {
                                  task.addTask(
                                      task: _task.text.trim(),
                                      status: 'Pending');
                                }
                              },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            // color: Colors.blue,
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
