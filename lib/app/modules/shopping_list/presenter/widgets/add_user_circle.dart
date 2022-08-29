import 'package:flutter/material.dart';
import '/app/shared/themes/themes.dart';

class AddUserCircle extends StatelessWidget {
  final VoidCallback onPressed;
  final bool noUsers;
  const AddUserCircle({Key? key, this.noUsers = false, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: context.colorsScheme.secondaryContainer,
        child: Icon(
          noUsers ? Icons.group_add_outlined : Icons.add,
          color: context.colorsScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}
