import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:messagaty/widgets/glowing_action_button_widget.dart';

import '../theme.dart';

class ChatScreenSendMessageBarWidget extends StatelessWidget {
  const ChatScreenSendMessageBarWidget({Key? key}) : super(key: key);

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
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: TextField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Type something...',
                      border: InputBorder.none,
                    ),
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
                  onPressed: () {
                    print('TODO: send a message');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}