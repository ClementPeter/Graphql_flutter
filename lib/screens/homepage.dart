import 'package:flutter/material.dart';
import 'package:graphql_app/providers/get_task_provider.dart';
import 'package:graphql_app/screens/add_todo_page.dart';
import 'package:provider/provider.dart';

import '../providers/delete_task_provider.dart';

//Main page in our App ; Displays List of ToDos
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isFetched =
      false; //to avaoid overfetching data we use this boolean to check
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("GraphQl App"),
      ),
      //Custom scroll view provides a cool animation look when we scroll
      body: Consumer<GetTaskProvider>(builder: (context, task, child) {
        if (_isFetched == false) {
          task.getTask();
          //delays for 3 sec and triggers _IsFetched to prevent graphQl from overfetching data from task.getData
          Future.delayed(const Duration(seconds: 2), () => _isFetched = true);
        }
        return RefreshIndicator(
          onRefresh: () {
            task.getTask(); //On screen refresh fetch tasks
            return Future.delayed(const Duration(seconds: 2));
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 50, top: 10),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child:
                            const Center(child: Text('Swipe down to refresh')),
                      ),
                      if (task.getResponseData().isEmpty)
                        const Text("No Todo found"),
                      Expanded(
                        child: ListView(
                          children: List.generate(task.getResponseData().length,
                              (index) {
                            final data = task.getResponseData()[
                                index]; //Uased to populate the ListTile
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                tileColor: Colors.grey[300],
                                // /contentPadding: const EdgeInsets.all(5),
                                title: Text(data["task"]),
                                subtitle: Text(data["timeAdded"].toString()),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  child: Text(
                                    data["id"].toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                //Delete Task Button - Consumer helps to inject the provider into the button in order for the provider to be trigger
                                trailing: Consumer<DeleteTaskProvider>(
                                  builder: (context, deleteTask, child) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback(
                                      (_) {
                                        if (deleteTask.getResponse != '') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text(deleteTask.getResponse),
                                            ),
                                          );
                                          deleteTask.clear();
                                        }
                                      },
                                    );
                                    return IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Color.fromARGB(255, 114, 33, 27),
                                        // color: deleteTask.status == true ? Colors.grey : Colors.white,
                                      ),
                                      //Shows Snackbat for user to confirm Deleteion
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            //backgroundColor: Colors.white,
                                            content: const Text(
                                              "Are you sure you want to delete this task",
                                            ),
                                            action: SnackBarAction(
                                              label: "Delete Now",
                                              onPressed: () {
                                                deleteTask.deleteTask(
                                                  taskId: data["id"],
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                        //
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      //To prevent the Todo Task from hiding underneath the Floating Action Button
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTodoPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Todo'),
      ),
    );
  }
}
