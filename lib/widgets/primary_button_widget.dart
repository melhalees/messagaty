import 'package:flutter/material.dart';
import 'package:messagaty/theme.dart';

class PrimaryButtonWidget extends StatelessWidget {
  const PrimaryButtonWidget({Key? key, required this.onPressed, required this.text}) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
        child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600
            ),
        )
    );
  }
}
