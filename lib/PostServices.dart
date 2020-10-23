import 'package:http/http.dart' as http;
import 'Post.dart';

class Services {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  static Future<List<Post>> getPosts() async {
    try{
        final response = await http.get(url);
        if(response.statusCode == 200) {
          final List<Post> listPosts = postFromJson(response.body);
          return listPosts; 
        }else{
          return List<Post>();
        }
    }catch(e){
      return List<Post>();
    }
  }
}
