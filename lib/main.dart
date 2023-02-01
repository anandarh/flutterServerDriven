import 'package:flutter/material.dart';
import 'package:flutter_server_driven/pages/form_page.dart';
import 'package:flutter_server_driven/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Utils.registerFunctions;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Server Driven',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainApp());
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Server Driven'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(4),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FormPage(),
                ),
              );
            },
            splashColor: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  Icon(Icons.download),
                  SizedBox(width: 15),
                  Text('Load Feature A'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
