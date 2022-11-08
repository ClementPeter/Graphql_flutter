import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  //const AddTodoPage({super.key, required this.title});
  const AddTodoPage({Key? key}) : super(key: key);

  //final String title;

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
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
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text('Add your first todo'),
                  ),
                  TextFormField(
                    controller: _task,
                    decoration: const InputDecoration(
                      labelText: 'Todo Task',
                    ),
                  ),
                  GestureDetector(
                    // onTap: task.getStatus == true
                    //     ? null
                    //     : () {
                    //         ///Add task button
                    //         ///
                    //         print(_task.text);
                    //         if (_task.text.isNotEmpty) {
                    //           task.addTask(
                    //               task: _task.text.trim(), status: 'Pending');
                    //         }
                    //       },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          // color: task.getStatus == true
                          //     ? Colors.grey
                          //     : Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      // child: Text(task.getStatus == true
                      //     ? 'Loading...'
                      //     : 'Save Task'),
                    ),
                  )
                  // Expanded(
                  //   child: ListView(
                  //     children: List.generate(30, (index) {
                  //       return ListTile(
                  //         title: Text("Todo Title"),
                  //         subtitle: Text("Todo time"),
                  //         leading: CircleAvatar(
                  //           backgroundColor: Colors.grey,
                  //         ),
                  //         trailing: IconButton(
                  //           onPressed: () {},
                  //           icon: const Icon(Icons.delete),
                  //         ),

                  //       );
                  //     }),
                  //   ),
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
