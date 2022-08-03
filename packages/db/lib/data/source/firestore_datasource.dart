import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreDatasource {
  const FirestoreDatasource({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  @visibleForTesting
  static const userCollectionKey = "user";

  final FirebaseFirestore _firebaseFirestore;

  /// return the auto generated id
  Future<String> createUser({required Map<String, dynamic> data}) async {
    final user =
        await _firebaseFirestore.collection(userCollectionKey).add(data);
    return user.id;
  }
}

final firebaseFirestore = FirebaseFirestore.instance;
