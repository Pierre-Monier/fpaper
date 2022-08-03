class AuthUser {
  const AuthUser({
    required this.uid,
    required this.username,
    required this.profilePicturesPath,
  });
  final String uid;
  final String? username;
  final String? profilePicturesPath;
}
