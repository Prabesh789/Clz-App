import 'dart:ffi';
import 'package:Hello_Doctor/model/registerModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> upsertData(Model model) {
    var options = SetOptions(merge: true);
    return _db
        .collection(model.table)
        .doc(model.registerId)
        .set(model.toMap(), options);
  }

  Stream<List<Model>> getData(String tableName) {
    return _db.collection(tableName).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Model.fromJson(doc.data())).toList());
  }

  Future<Void> deleteData(String tableName, String dataId) {
    return _db.collection(tableName).doc(dataId).delete();
  }
}
