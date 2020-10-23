import 'package:flutter/material.dart';
import 'UserServices.dart';
import 'User.dart';
//import 'PostScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter UserView'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users;
  bool loading;

  @override
  void initState() {
    super.initState();
    loading = true;
    Services.getUsers().then((list) {
      users = list;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loading ? 'Loading ...' : 'Users'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(itemBuilder: (context, index) {
          User user = users[index];
          return ListTile(
            title: Text(index.toString() + ". " + user.name),
            subtitle: Text(user.email),
          );
        }),
      ),
    );
  }
}
