class User {
  final String userName;
  final String id;
  String? image;
  final String message;
  final String sent;

  User({
    required this.userName,
    required this.id,
    this.image,
    required this.message,
    required this.sent,
  });
}
