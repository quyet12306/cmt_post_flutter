// ignore: file_names
// ignore: file_names
import 'package:demo_social_network/UpLoad-Screen/home_page.dart';
import 'package:demo_social_network/UpLoad-Screen/upload_screen.dart';
import 'package:demo_social_network/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:demo_social_network/controller/rest_api.dart';
import 'package:demo_social_network/model/response_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  ResponseModel responseModel = new ResponseModel();
  bool _isLiked = false;
  int _likeCount = 0;
  int _commentCount = 0;
  List<PostModel> listData = [];

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _likeCount += _isLiked ? 1 : -1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    listData = await RestAPI().getAPI();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Feed'),
        ),
        body: ListView.builder(
          itemCount: listData.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                    ),
                    title: Text(listData[index].id.toString()),
                    subtitle: Text("2 Hour ago"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(listData[index].body ?? ""),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: _isLiked ? Colors.red : null,
                        ),
                        onPressed: _toggleLike,
                      ),
                      Text('$_likeCount'),
                      IconButton(
                          icon: Icon(Icons.comment),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Homepage(id: listData[index].id ?? 0)));
                          }),
                      Text('$_commentCount'),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Upload()),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}
