import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreDatasource {
  const FirestoreDatasource({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  @visibleForTesting
  static const userCollectionKey = "user";

  final FirebaseFirestore _firebaseFirestore;

  /// return the created data
  Future<Map<String, dynamic>> createUser({
    required Map<String, dynamic> data,
    required String id,
  }) async {
    await _firebaseFirestore.collection(userCollectionKey).doc(id).set(data);
    return data;
  }

  Future<Map<String, dynamic>?> getUserById({required String id}) async {
    final snapshot =
        await _firebaseFirestore.collection(userCollectionKey).doc(id).get();

    return snapshot.data();
  }
}

final firebaseFirestore = FirebaseFirestore.instance;
