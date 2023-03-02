import 'dart:convert';

import 'package:demo_social_network/model/post_model.dart';

class ResponseModel {
  List<PostModel>? result;

  ResponseModel({
    this.result,
  });
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      result: List<PostModel>.from(json["result"].map((e) => PostModel.fromJson(e))),
    );
    // result = List<PostModel>.from(json["result"].map((e) => PostModel.fromJson(e)));
  }

}

ResponseModel parseJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ResponseModel>((json) => ResponseModel.fromJson(json)).toList();
}