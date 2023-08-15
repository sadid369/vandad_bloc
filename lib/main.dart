// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vandad_bloc/person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blocs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonAction implements LoadAction {
  final PersonUrl url;
  const LoadPersonAction({required this.url}) : super();
}

enum PersonUrl {
  person1,
  person2,
}

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return "http://127.0.0.1:5500/api/person1.json";
      case PersonUrl.person2:
        return "http://127.0.0.1:5500/api/person2.json";
    }
  }
}

Future<List<Person>?> getPersons(String url) async {
  List<Person> person;
  try {
    var res = await http.get(Uri.parse(url));
    person = personFromJson(res.body);

    return person;
  } catch (e) {
    print(e.toString());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              getPersons("http://192.168.0.102:5500/api/person2.json");
            },
            child: Text('Get')),
      ),
    );
  }
}
