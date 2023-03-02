import 'dart:convert';
import 'package:demo_social_network/model/post_model.dart';
import 'package:demo_social_network/model/response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RestAPI {
  final String accessToken =
      // '118a023dd394a879c75850b878af56a0c48c6e64a5b383095d3b8e5dd1f9a65e';
      '84e1f160175bed1561319ba88aff7f4add106e3a9ee574ea2379b46ab7e27172';
  Future getAPI() async {
    var url = Uri.parse('https://gorest.co.in/public/v2/users/663608/posts');
    var headers = {'Authorization': 'Bearer $accessToken'};
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url, headers: headers);
    print(response.toString());
    // final Map<String, dynamic> parsed = json.decode(response.body);
    List<PostModel> list = (json.decode(response.body) as List)
        .map((data) => PostModel.fromJson(data))
        .toList();
    return list;
  }

  Future<void> addPost(PostModel postModel, int id) async {
    final url = Uri.parse('gorest.co.in/public/v2/users/505972/posts');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(postModel.toMap()),
    );
    if (response.statusCode == 201) {
      print('Post created successfully!');
    } else {
      throw Exception('Failed to create post.');
    }
  }

  Future<void> updatePost(int id, String title, String body) async {
    final url = Uri.parse(
        'http://web.bluecomtech.com/Online%20Free%20REST%20API/gorest.co.in/public-api/posts7bd2.json?_format=json&access-token=ggolvSv4UpUH_a9Qk5x5KAC2YudbptpltVYZ');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'body': body}),
    );
    if (response.statusCode == 200) {
      print('Post updated successfully!');
    } else {
      throw Exception('Failed to update post.');
    }
  }
}
