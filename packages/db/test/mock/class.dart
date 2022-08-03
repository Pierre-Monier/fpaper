// ignore_for_file: avoid_implementing_value_types, subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';

class MockFireFirestore extends Mock implements FirebaseFirestore {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

final mockFirebaseFirestore = MockFireFirestore();
final mockDocumentReference = MockDocumentReference();
final mockCollectionReference = MockCollectionReference();
