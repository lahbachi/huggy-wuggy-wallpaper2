import 'dart:convert';

List<ChangePost> changePostFromJson(String str) =>
    List<ChangePost>.from(json.decode(str).map((x) => ChangePost.fromJson(x)));
class ChangePost {
  String? url;

  ChangePost({this.url});

  ChangePost.fromJson(Map<String, dynamic> json) {
    url = json['url']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}