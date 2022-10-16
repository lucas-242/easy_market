import '../../domain/entities/collaborator.dart';
import '../../../../shared/extensions/extensions.dart';
import '../../../../shared/themes/themes.dart';
import 'package:flutter/material.dart';

class CollaboratorCircle extends StatelessWidget {
  final VoidCallback? onPressed;
  final Collaborator collaborator;
  const CollaboratorCircle(
      {Key? key, required this.collaborator, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: CircleAvatar(
          backgroundColor: collaborator.isAlreadyUser
              ? context.colorsScheme.primaryContainer
              : context.colorsScheme.surfaceVariant,
          child: Text(
            collaborator.name.getInitials(),
            style: TextStyle(
              color: context.colorsScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
