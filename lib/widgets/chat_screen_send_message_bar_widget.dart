import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:messagaty/widgets/glowing_action_button_widget.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../theme.dart';

class ChatScreenSendMessageBarWidget extends StatefulWidget {
  const ChatScreenSendMessageBarWidget({Key? key}) : super(key: key);

  @override
  State<ChatScreenSendMessageBarWidget> createState() => _ChatScreenSendMessageBarWidgetState();
}

class _ChatScreenSendMessageBarWidgetState extends State<ChatScreenSendMessageBarWidget> {

  final StreamMessageInputController controller = StreamMessageInputController();

  Timer? _debounce;

  Future<void> _sendMessage() async {
    if (controller.text.isNotEmpty) {
      StreamChannel.of(context).channel.sendMessage(controller.message);
      controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  void _onTextChange() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        StreamChannel.of(context).channel.keyStroke();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    controller.removeListener(_onTextChange);
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final brightness = Theme.of(context).brightness;

    return Card(
      color: brightness == Brightness.light ? Colors.transparent : null,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 2,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(
                    Ionicons.camera,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    controller: controller.textFieldController,
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: 'Type something...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 24.0,
                ),
                child: GlowingActionButtonWidget(
                  color: AppColors.accent,
                  icon: Icons.send_rounded,
                  onPressed: _sendMessage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}