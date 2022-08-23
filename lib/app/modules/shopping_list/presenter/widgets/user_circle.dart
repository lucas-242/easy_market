import 'package:easy_market/app/shared/extensions/extensions.dart';
import 'package:easy_market/app/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class UserCircle extends StatelessWidget {
  final String name;
  const UserCircle({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorsScheme.tertiaryContainer,
      child: Text(name.getInitials()),
    );
  }
}
