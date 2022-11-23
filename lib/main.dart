import 'package:flutter/material.dart';
import 'package:graphql_app/providers/add_task_provider.dart';
import 'package:graphql_app/providers/get_task_provider.dart';
import 'package:graphql_app/screens/homepage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await initHiveForFlutter(); //InitializinG Hive since it's the default storing mechanism for Graphql
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddTaskProvider()),
        ChangeNotifierProvider(create: (context) => GetTaskProvider())
      ],
      child: const MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}
