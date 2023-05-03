import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

extension StreamChatContextExtension on BuildContext {
  /// Fetches the current user image.
  String? get currentUserImage => currentUser!.image;

  /// Fetches the current user.
  User? get currentUser => StreamChatCore.of(this).currentUser;
}