// To parse this JSON data, do
//
//     final Comment = PostFromJson(jsonString);

import 'dart:convert';

List<Comment> PostFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String PostToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  Comment({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        postId: json["post_id"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId.toString(),
        "id": id.toString(),
        "name": name,
        "email": email,
        "body": body,
      };
  Map<String, dynamic> toJsonPut() => {
        "post": postId.toString(),
        "id": id.toString(),
        "name": name,
        "email": email,
        "body": body,
      };
}
