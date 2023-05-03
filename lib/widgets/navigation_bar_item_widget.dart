import 'package:flutter/material.dart';
import 'package:messagaty/theme.dart';

class NavigationBarItemWidget extends StatelessWidget {
  const NavigationBarItemWidget({
    Key? key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final bool isSelected;

  final int index;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
                icon,
                color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? AppColors.secondary : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
