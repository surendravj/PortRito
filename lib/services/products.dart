import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final CollectionReference _firestore = Firestore.instance.collection('Arts');

  getData() async {
    await _firestore.getDocuments().then((QuerySnapshot snapshot) => {
          snapshot.documents.forEach((element) {
            print(element.data);
          })
        });
  }
}
