import '../../../../shared/extensions/extensions.dart';
import '../../../../shared/themes/themes.dart';
import 'package:flutter/material.dart';

class UserCircle extends StatelessWidget {
  final VoidCallback? onPressed;
  final String name;
  const UserCircle({Key? key, required this.name, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: CircleAvatar(
          backgroundColor: context.colorsScheme.tertiaryContainer,
          child: Text(name.getInitials()),
        ),
      ),
    );
  }
}
