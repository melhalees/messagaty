import 'package:flutter/material.dart';

class DisplayErrorMessageWidget extends StatelessWidget {
  const DisplayErrorMessageWidget({Key? key, this.error}) : super(key: key);

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Oh no, something went wrong. '
            'Please check your config. $error',
      ),
    );
  }
}