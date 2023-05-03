import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ChatScreenTypingStatusBuilderWidget extends StatelessWidget {
  /// Instantiate a new TypingIndicator
  const ChatScreenTypingStatusBuilderWidget({
    Key? key,
    this.alternativeWidget,
  }) : super(key: key);

  /// Widget built when no typings is happening
  final Widget? alternativeWidget;

  @override
  Widget build(BuildContext context) {
    final channelState = StreamChannel.of(context).channel.state!;

    final altWidget = alternativeWidget ?? const SizedBox.shrink();

    return BetterStreamBuilder<Iterable<User>>(
      initialData: channelState.typingEvents.keys,
      stream: channelState.typingEventsStream
          .map((typings) => typings.entries.map((e) => e.key)),
      builder: (context, data) {
        return Align(
          alignment: Alignment.centerLeft,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: data.isNotEmpty == true
                ? const Align(
              alignment: Alignment.centerLeft,
              key: ValueKey('typing-text'),
              child: Text(
                'Typing ...',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : Align(
              alignment: Alignment.centerLeft,
              key: const ValueKey('altwidget'),
              child: altWidget,
            ),
          ),
        );
      },
    );
  }
}