import 'package:demo_social_network/controller/rest_api.dart';
import 'package:demo_social_network/model/response_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import '../model/post_model.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}


class _UploadState extends State<Upload> {
  TextEditingController? _textEditingController;
  File? _image;
  ResponseModel responseModel = new ResponseModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _showImagePickerDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose an option"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Take a picture"),
                  onTap: () {
                    _getImageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Select from gallery"),
                  onTap: () {
                    _getImageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              final postModel = PostModel(
                body: _textEditingController!.text,
              );
              RestAPI().addPost(postModel, 505972);
              },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'What\'s on your mind?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 16.0),
          _image != null
              ? Image.file(
            _image!,
            height: 200.0,
          )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showImagePickerDialog,
        tooltip: 'Add Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}


