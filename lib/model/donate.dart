import 'dart:convert';

List<Donate> donateFromJson(String str) =>
    List<Donate>.from(json.decode(str).map((x) => Donate.fromJson(x)));

String  donateToJson(List<Donate> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donate {
  Donate({
    this.buyMeaCoffee,
    this.crypto,
    this.paypal,
  });

  Donated? buyMeaCoffee;
  Donated? crypto;
  Donated? paypal;

  factory Donate.fromJson(Map<String, dynamic> json) => Donate(
    buyMeaCoffee: Donated.fromJson(json["buymeacoffee"]),
    crypto: Donated.fromJson(json["crypto"]),
    paypal: Donated.fromJson(json["paypal"]),
  );

  Map<String, dynamic> toJson() => {
    "buymeacoffee": buyMeaCoffee!.toJson(),
    "crypto": crypto!.toJson(),
    "paypal": paypal!.toJson(),
  };
}

class Donated {
  Donated({
    this.name,
    this.link,
    this.active,
  });

  String? name;
  String? link;
  bool? active;

  factory Donated.fromJson(Map<String, dynamic> json) => Donated(
    name: json["name"],
    link: json["link"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "link": link,
    "active": active,
  };
}
