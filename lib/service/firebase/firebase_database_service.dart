import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../model/firebase_file.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(
          List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<Favourite>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    print("ref $ref");
    final result = await ref.listAll();
    print("result ${result.items}");
    final urls = await _getDownloadLinks(result.items);
    print("urls $urls");
    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = Favourite(ref: ref, name: name, url: url);
          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static Future<QuerySnapshot> getUnitAd({required String methode}) async {
    var documentReferencer = _firestore.collection(methode); //.collection('email/password').doc()
    return documentReferencer.get();
  }

}
