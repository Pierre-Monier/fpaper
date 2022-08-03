import 'package:db/data/source/firestore_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/class.dart';
import '../../mock/data.dart';

void main() {
  setUpAll(() {
    when(
      () => mockFirebaseFirestore
          .collection(FirestoreDatasource.userCollectionKey),
    ).thenAnswer((_) => mockCollectionReference);
    when(() => mockCollectionReference.add(mockUserData))
        .thenAnswer((_) => Future.value(mockDocumentReference));
    when(() => mockDocumentReference.id).thenReturn(mockUserId);
  });

  test('it should be able to create document and return the generated id',
      () async {
    final firestoreDatasource =
        FirestoreDatasource(firebaseFirestore: mockFirebaseFirestore);

    final userId = await firestoreDatasource.createUser(data: mockUserData);
    expect(userId, mockUserId);
  });
}
