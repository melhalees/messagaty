import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
    this.url,
    required this.radius,
    this.onTap,
  }) : super(key: key);

  const AvatarWidget.small({
    Key? key,
    this.url,
    this.onTap,
  })  : radius = 18,
        super(key: key);

  const AvatarWidget.medium({
    Key? key,
    this.url,
    this.onTap,
  })  : radius = 26,
        super(key: key);

  const AvatarWidget.large({
    Key? key,
    this.url,
    this.onTap,
  })  : radius = 34,
        super(key: key);

  final double radius;
  final String? url;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _avatar(context),
    );
  }

  Widget _avatar(BuildContext context) {
    if (url != null && url!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(url!),
        backgroundColor: Theme.of(context).cardColor,
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).cardColor,
        child: Center(
          child: Text(
            '?',
            style: TextStyle(fontSize: radius),
          ),
        ),
      );
    }
  }
}