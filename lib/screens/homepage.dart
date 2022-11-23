import 'package:flutter/material.dart';
import 'package:graphql_app/providers/get_task_provider.dart';
import 'package:graphql_app/screens/add_Todo_page.dart';
import 'package:provider/provider.dart';

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
          Future.delayed(const Duration(seconds: 3), () => _isFetched = true);
        }

        return RefreshIndicator(
          onRefresh: () {
            task.getTask(); //On screen refresh fetch tasks
            return Future.delayed(const Duration(seconds: 3));
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 50, top: 10),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text('Available Todo'),
                      ),
                      if (task.getResponseData().isEmpty) Text("No Todo found"),
                      Expanded(
                        child: ListView(
                          children: List.generate(task.getResponseData().length,
                              (index) {
                            final data = task.getResponseData()[
                                index]; //Uased to populate the ListTile
                            return ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: Text(data["task"]),
                              subtitle: Text(data["timeAdded"].toString()),
                              leading: const CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 100)
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
      // child: const Icon(Icons.add),
    );
  }
}
