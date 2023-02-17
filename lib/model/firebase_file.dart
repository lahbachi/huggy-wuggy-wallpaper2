import 'package:firebase_storage/firebase_storage.dart';

// class FirebaseFile {
//    Reference? ref;
//    String? name;
//    String? url;
//
//    FirebaseFile({
//      this.ref,
//      this.name,
//      this.url,
//   });
// }
class Favourite {
  Reference? ref;
  String? name;
  String? url;
  bool isSelected;

  Favourite({
    this.name,
    this.url,
    this.ref,
    this.isSelected = false,
  });
  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
    name: json["name"],
    url: json["url"],
    ref: json["ref"],
    isSelected: json["isSelected"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "ref": ref,
    "url": url,
    "isSelected": isSelected,
  };
}

