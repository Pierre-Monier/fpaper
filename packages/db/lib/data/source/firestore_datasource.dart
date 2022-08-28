import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatasource {
  const FirestoreDatasource({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  static const _userCollectionKey = "user";
  static const _deviceCollectionKey = "user";

  final FirebaseFirestore _firebaseFirestore;

  /// return the created data
  Future<Map<String, dynamic>> createUser({
    required Map<String, dynamic> data,
    required String id,
  }) async {
    await _firebaseFirestore.collection(_userCollectionKey).doc(id).set(data);
    return data;
  }

  Future<Map<String, dynamic>?> getUserById({required String id}) async {
    final snapshot =
        await _firebaseFirestore.collection(_userCollectionKey).doc(id).get();

    return snapshot.data();
  }

  Future<List<Map<String, dynamic>>> getUserDevices({
    required String userId,
  }) async {
    final query = await _firebaseFirestore
        .collection(_deviceCollectionKey)
        .where("userId", isEqualTo: userId)
        .get();

    // * we add the document id to the return value
    return query.docs.map((e) => {"id": e.id, ...e.data()}).toList();
  }

  Future<Map<String, dynamic>> createDevice({
    required Map<String, dynamic> data,
  }) async {
    final deviceDoc =
        await _firebaseFirestore.collection(_deviceCollectionKey).add(data);

    return {
      "id": deviceDoc.id,
      ...data,
    };
  }
}

final firebaseFirestore = FirebaseFirestore.instance;
