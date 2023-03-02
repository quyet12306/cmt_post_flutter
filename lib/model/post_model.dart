class PostModel {
  int? id ;
  int? user_id;
  String? title;
  String? body;

  PostModel({this.id, this.user_id, this.title, this.body});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    title = json['title'];
    body = json['body'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'title': title,
      'body': body,
    };
    return map;
  }
}
