//import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';

class TestApi extends StatefulWidget {
  @override
  _TestApiState createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {
  List photos = [];
  // List<String> foo = List.filled();
  @override
  void initState() {
    // TODO: implement initState
    _setdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(photos);
    return Scaffold(
      body: _build(),
    );
  }

  _build() {
    return new Container(
      child: ListView.builder(
          itemCount: photos.length,
          itemBuilder: (BuildContext context, int count) {
            var photo = photos[count];
            return InkWell(
              onTap: () {
                setState(() {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(photo['title']),
                      action: SnackBarAction(label: 'Close', onPressed: () {}),
                      duration: Duration(milliseconds: 1000),
                    ));
                });
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                height: 80,
                decoration: BoxDecoration(

                    // color: Colors.yellow,
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(photo['title']),
                  subtitle: Text(photo['id'].toString()),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(photo['url']),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _setdata() async {
    late var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    //late var url2 = Uri.parse('http://shohadakhanmirza.com/api/article');

    var respone = await http.get(url);
    if (respone.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(respone.body);
      //  var itemCount = jsonResponse['totalItems'];
      photos = jsonResponse;
      print(photos);
      setState(() {});
    } else {
      print(respone.statusCode);
    }
  }
}
