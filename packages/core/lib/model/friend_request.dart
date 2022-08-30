class FriendRequest {
  const FriendRequest({
    required this.from,
    required this.to,
    required this.status,
  });

  /// The user id of the user who sent the friend request.
  final String from;

  /// The user id of the user who received the friend request.
  final String to;

  /// The status of the friend request.
  final FriendRequestStatus status;
}

enum FriendRequestStatus {
  pending,
  accepted,
  rejected,
}
