import 'package:flutter_application_1/task2.dart';
import 'package:flutter/material.dart';
import 'dart:async';

var data = [];
void main() {
  runApp(const MyApp());
  getUserData();
  print("Getting user data ...");
}

class User {
  final String name;
  final String phoneNumber;

  User(this.name, this.phoneNumber);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //home: const MyHomePage(title: 'Flutter Demo Home Page'));
        home: contoh2());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 120,
            ),
            Text(
              'Daftar Pengguna',
              style: Theme.of(context).textTheme.headline6,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Center(child: Text(data[index].name)),
                    subtitle: Center(child: Text(data[index].phoneNumber)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> getUserData() {
  // Simulate getting user data
  data = [
    User('Bunny', '081-432-2211 | bunny@example.com'),
    User('Funny', '089-231-6453 | funny@example.com'),
    User('Miles', '080-938-4356 | miles@example.com'),
  ];

  return Future.delayed(const Duration(seconds: 3), () {
    print("Downloaded ${data.length} data");
  });
}
