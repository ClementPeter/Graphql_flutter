import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      //Custome scroll view provides a cool animation look when we scroll
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Text('Available Todo'),
                  ),
                  Expanded(
                    child: ListView(
                      children: List.generate(30, (index) {
                        return ListTile(
                          title: Text("Todo Title"),
                          subtitle: Text("Todo time"),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          trailing: IconButton(
                            onPressed: (){},
                            icon: const  Icon(Icons.delete),
                          ),
                          // trailing:  IconButton(
                          //  // icon: Icon(Icons.delete),
                          //   icon: const Icon(Icons.delete)
                          // ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        // label: ,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        icon: const Icon(Icons.add),
        label: const Text('Add Todo'),
      ),
      // child: const Icon(Icons.add),
    );
  }
}
