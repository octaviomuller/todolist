import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreService {
  Stream<dynamic> listenDocuments(collection) {
    return FirebaseFirestore.instance.collection(collection).snapshots();
  }

  Future<dynamic> fetchDocuments(collection) async{
    return FirebaseFirestore.instance.collection(collection).get();
  }

  Future<dynamic> fetchDocument(collection, docId) async {
    return FirebaseFirestore.instance.collection(collection).doc(docId).get();
  }

  Stream<dynamic> listenDocument(collection, docId) {
    return FirebaseFirestore.instance.collection(collection).doc(docId).snapshots();
  }

  Future createDocument(collection, data, {docId}) async {
    if (docId == null)
      return FirebaseFirestore.instance.collection(collection).doc().set(data);
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(docId)
        .set(data);
  }

  Future newDocument(collection, data) async {
    return FirebaseFirestore.instance.collection(collection).add(data);
  }

  Future updateDocument(collection, docId, data) async {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(docId)
        .update(data);
  }

  Future deleteDocument(collection,docId) async{
    return FirebaseFirestore.instance.collection(collection).doc(docId).delete();
  }


}
