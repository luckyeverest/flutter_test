import 'package:flutter/material.dart';
import 'PhotoModel.dart';
import 'package:http/http.dart' as http;

Future<List<PhotoData>> fetchAlbum() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/photos');

  if (response.statusCode == 200) {
    List<PhotoData> list = PhotoData.parsePhotos(response.body);
    return list;
  } else {
    throw Exception('Failed to load album');
  }
}



class PhotoPage extends StatefulWidget {
  PhotoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  Future<List<PhotoData>> futurePhoto;

  @override
  void initState() {
    super.initState();
    futurePhoto = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder<List<PhotoData>>(
        future: futurePhoto,
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            print("nope");
            return Center(child: CircularProgressIndicator());
          } else {
            print(snapshot.data);
            return Container(child: _albumGridView(snapshot.data));
          }
        },
      )),
    );
  }
}

GridView _albumGridView(List<PhotoData> data) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemCount: data.length,
    padding: EdgeInsets.all(2.0),
    itemBuilder: (BuildContext context, int index) {
      return _tile(data[index].id.toString(), data[index].title,
          data[index].thumbnailUrl);
    },
  );
}

GridTile _tile(String id, String title, String photoUrl) => GridTile(
    child: InkWell(
        onTap: () => print("click"),
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), 
                  ),
                ], borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.network(photoUrl, fit: BoxFit.contain),
                      ),
                      Container(
                        child: Text(title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            )),
                      ),
                    ])))));