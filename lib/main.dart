import 'package:demo_social_network/UpLoad-Screen/Post_Screen.dart';
import 'package:demo_social_network/UpLoad-Screen/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'UpLoad-Screen/home_page.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: PostScreen());
    // home: Homepage());
  }
}
