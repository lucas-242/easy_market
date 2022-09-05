import 'package:flutter/material.dart';
import '/app/shared/themes/themes.dart';

class AddCollaboratorCircle extends StatelessWidget {
  final VoidCallback onPressed;
  final bool noCollaborators;
  const AddCollaboratorCircle(
      {Key? key, this.noCollaborators = false, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        backgroundColor: context.colorsScheme.primaryContainer,
        child: Icon(
          noCollaborators ? Icons.group_add_outlined : Icons.add,
          color: context.colorsScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
