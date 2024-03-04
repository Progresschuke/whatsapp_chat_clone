enum MessageType {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  gif('gif');

  const MessageType(this.type);
  final String type;
}

extension ConvertMessage on String {
  MessageType toEnum() {
    switch (this) {
      case 'text':
        return MessageType.text;
      case 'image':
        return MessageType.image;
      case 'audio':
        return MessageType.audio;
      case 'video':
        return MessageType.video;
      case 'gif':
        return MessageType.gif;

      default:
        return MessageType.text;
    }
  }
}

/**here, since the database accepts a string, we would use extension& enhanced enums to be able
 to convert the enum to string and also from string to enum when we want to utilize it in our application
 **/

