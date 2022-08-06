import 'package:auth/data/source/firebase_auth_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseAuthDatasource extends Mock
    implements FirebaseAuthDataSource {}

class MockFirebaseUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class OAuthCredentialFake extends Fake implements OAuthCredential {}

final mockFirebaseAuth = MockFirebaseAuth();
final mockFirebaseAuthDatasource = MockFirebaseAuthDatasource();
final mockFirebaseAuthDataChange = BehaviorSubject<User?>.seeded(null);
final mockFirebaseUser = MockFirebaseUser();
final mockUserCredential = MockUserCredential();
