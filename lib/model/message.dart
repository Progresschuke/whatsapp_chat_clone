class Message {
  final String msg;
  final String sent;
  final String read;
  final String fromId;
  final String toId;

  Message({
    required this.msg,
    required this.sent,
    required this.read,
    required this.fromId,
    required this.toId,
  });
}
