import 'package:meta/meta.dart';

@immutable
class MessageTileDataModel {

  const MessageTileDataModel({
      required this.senderName,
      required this.senderImage,

      required this.messageText,
      required this.messageDateTime,
      required this.messageDateTimeAsString,

      required this.isMessageRead,
      required this.isMessageSent,
      required this.isMessageDelivered,

      this.isMe = false
  });

  final String senderName;
  final String senderImage;

  final String messageText;
  final DateTime messageDateTime;
  final String messageDateTimeAsString;

  final bool isMessageRead;
  final bool isMessageSent;
  final bool isMessageDelivered;

  final bool isMe;
}