import 'package:flutter/material.dart';
import 'PostServices.dart';
import 'Post.dart';

class PostPage extends StatefulWidget {
  PostPage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  List<Post> posts;
  bool loading;

  @override
  void initState() {
    super.initState();
    loading =true;
    Services.getPosts().then((list) {
      posts = list;
      loading= false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loading ? 'Loading ...': 'Posts'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: (context,index){
            Post post = posts[index];
            return ListTile(
              title: Text(index.toString() + ". " + post.title),
              subtitle: Text(post.body),
            );
          }
          ),
      ),
    );
  }
}