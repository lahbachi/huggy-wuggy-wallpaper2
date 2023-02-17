import 'dart:convert';

List<SocialMedia> socialMediaFromJson(String str) =>
    List<SocialMedia>.from(json.decode(str).map((x) => SocialMedia.fromJson(x)));
class SocialMedia {
  String? name;
  String? iconPath;
  String? url;
  bool? active;
  String? country;

  SocialMedia({this.name, this.iconPath, this.url,this.active,this.country});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    name = json['name']??"";
    iconPath = json['iconPath']??"";
    url = json['url']??"";
    active = json['active']??false;
    country = json['country']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['iconPath'] = iconPath;
    data['url'] = url;
    data['country'] = country;
    data['active'] = active;
    return data;
  }
}