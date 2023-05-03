import 'package:flutter/material.dart';
import 'package:messagaty/widgets/chat_screen_date_label_widget.dart';
import 'package:messagaty/widgets/chat_screen_message_widget.dart';
import 'package:messagaty/widgets/chat_screen_own_message_widget.dart';

class DemoMessageListWidget extends StatelessWidget {
  const DemoMessageListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: const [
          ChatScreenDateLabelWidget(label: 'Yesterday'),
          ChatScreenMessageWidget(
            message: 'Hi, Lucy! How\'s your day going?',
            messageDate: '12:01 PM',
          ),
          ChatScreenOwnMessageWidget(
            message: 'You know how it goes...',
            messageDate: '12:02 PM',
          ),
          ChatScreenMessageWidget(
            message: 'Do you want Starbucks?',
            messageDate: '12:02 PM',
          ),
          ChatScreenOwnMessageWidget(
            message: 'Would be awesome!',
            messageDate: '12:03 PM',
          ),
          ChatScreenMessageWidget(
            message: 'Coming up!',
            messageDate: '12:03 PM',
          ),
          ChatScreenOwnMessageWidget(
            message: 'YAY!!!',
            messageDate: '12:03 PM',
          ),
        ],
      ),
    );
  }
}
