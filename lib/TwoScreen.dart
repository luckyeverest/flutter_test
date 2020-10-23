import 'package:flutter/material.dart';
import 'UserServices.dart';
import 'User.dart';

class TwoScreenPage extends StatefulWidget {
  TwoScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TwoScreenPageState createState() => _TwoScreenPageState();
}

class _TwoScreenPageState extends State<TwoScreenPage> {
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
            subtitle: Text(user.email + user.phone),
          );
        }),
      ),
    );
  }
}
