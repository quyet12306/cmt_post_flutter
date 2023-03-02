// import 'package:flutter_application_1/moldel/post.dart';
// import 'package:flutter_application_1/moldel/comment.dart';

import 'dart:convert';

import 'package:demo_social_network/model/comment.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  final String accessToken =
      '84e1f160175bed1561319ba88aff7f4add106e3a9ee574ea2379b46ab7e27172'; // token quyet

  // '118a023dd394a879c75850b878af56a0c48c6e64a5b383095d3b8e5dd1f9a65e';//token hoang
  // var uri = Uri.parse("https://gorest.co.in/public/v2/posts/$id/comments");

  Future<List<Comment>?> getComment(int id) async {
    print(id);
    print("https://gorest.co.in/public/v2/posts/$id/comments");
    var headers = {'Authorization': 'Bearer $accessToken'};
    var client = http.Client();
    var uri = Uri.parse("https://gorest.co.in/public/v2/posts/$id/comments");

    var response = await client.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return PostFromJson(json);
    }
  }

  Future<List<Comment>?> postComment(Comment comment) async {
    // print(id);
    print(comment.toJson());
    var headers = {'Authorization': 'Bearer $accessToken'};
    var client = http.Client();
    var uri = Uri.parse(
        "https://gorest.co.in/public/v2/posts/${comment.postId}/comments");
    final response =
        await client.post(uri, headers: headers, body: comment.toJson());
    // tạo
    // if(response.statusCode == 201){
    //   return List<Comment>.fromJson(jsonDecode(response.body));
    // }
    print(response.statusCode);
  }

  Future<List<Comment>?> updateComment(Comment comment) async {
    // print(id);
    print(comment.toJson());
    var headers = {'Authorization': 'Bearer $accessToken'};
    var client = http.Client();
    var uri =
        Uri.parse("https://gorest.co.in/public/v2/comments/${comment.id}");
    final response =
        await client.put(uri, headers: headers, body: comment.toJsonPut());
    // tạo
    // if(response.statusCode == 201){
    //   return List<Comment>.fromJson(jsonDecode(response.body));
    // }
    print(response.statusCode);
    print(comment.toJsonPut());
    print("https://gorest.co.in/public/v2/comments/${comment.id}");
  }
}
