// import 'package:easy_market/app/core/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';
import '/app/shared/themes/themes.dart';

class UsersRow extends StatelessWidget {
  // List<User> users;
  const UsersRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          const Positioned(
            top: 12,
            right: 25,
            child: AddCircle(),
          ),
          const Positioned(
            top: 12,
            right: 50,
            child: UserCircle(),
          ),
          Positioned(
            top: 12,
            right: 75,
            child: CircleAvatar(
              backgroundColor: context.colorsScheme.tertiary,
              child: const Icon(Icons.person),
            ),
          )
        ],
      ),
    );
  }
}

class UserCircle extends StatelessWidget {
  const UserCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorsScheme.tertiaryContainer,
      child: const Icon(Icons.face),
    );
  }
}

class AddCircle extends StatelessWidget {
  const AddCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorsScheme.secondaryContainer,
      child: Icon(
        Icons.add,
        color: context.colorsScheme.onSecondaryContainer,
      ),
    );
  }
}
